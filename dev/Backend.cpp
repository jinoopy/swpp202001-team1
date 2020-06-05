
#include "Backend.h"

#include "llvm/ADT/SmallVector.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/InstrTypes.h"
#include "llvm/IR/InstVisitor.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Verifier.h"
#include "llvm/Support/raw_os_ostream.h"
#include <string>
#include <sstream>

using namespace llvm;
using namespace std;
using namespace backend;

namespace backend {

// Return sizeof(T) in bytes.
unsigned getAccessSize(Type *T) {
  if (isa<PointerType>(T))
    return 8;
  else if (isa<IntegerType>(T)) {
    return T->getIntegerBitWidth() == 1 ? 1 : (T->getIntegerBitWidth() / 8);
  } else if (isa<ArrayType>(T)) {
    return getAccessSize(T->getArrayElementType()) * T->getArrayNumElements();
  }
  assert(false && "Unsupported access size type!");
}

unsigned getBitWidth(Type* T) {
  if (isa<PointerType>(T))
    return 64;
  else if (isa<IntegerType>(T)) {
    return T->getIntegerBitWidth();
  }
  assert(false && "Unsupported access size type!");
}

//---------------------------------------------------------------
//class Backend
//---------------------------------------------------------------

PreservedAnalyses Backend::run(Module &M, ModuleAnalysisManager &MAM) {
  if (verifyModule(M, &errs(), nullptr)) {
    errs() << "Syntax error: Input module is not syntactically correct";
    exit(1);
  }

  //Build symbol table and rename all.
  //Every values are mapped to the symbol table.
  SymbolMap symbolMap(&M, TM);

  //Process alloca, stack pointer and related instructions.
  //- Allocas should reside only on the entry block.
  //- entry block should not have a predecessor block.
  //   => Else, raise error.
  //- allocas and its direct uses are renamed: __st__offset__ ex) __st__8__
  map<Function*, unsigned> spOffsetMap = processAlloca(M, symbolMap);

  //Debug code
  if(printProcess) {
    //Print GV. All GVs should be mapped.
    for(auto& glv : M.globals()) {
      outs() << "(" << symbolMap.get(&glv)->getName() << ")" << glv.getName() << "\n";
    }

    for(auto& F : M) {
      //Print function & argument. All arguments should be mapped.
      outs() << F.getName() << "(";
      for(auto& arg : F.args()) {
        outs() << " (" << symbolMap.get(&arg)->getName() << ")" << arg.getName();
      }
      outs() << " )\n";

      //Print Instructions. All instructions should be mapped.
      for(auto& BB : F) {
        outs() << "  " << BB.getName() << "\n";
        for(auto& I : BB) {
          if(isa<AllocaInst>(I)) {
            outs() << "    (" << symbolMap.get(&I)->getName() << ")" << I.getName() << "\n";
          }
          else if(RegisterGraph::DO_NOT_CONSIDER.find(I.getOpcode()) != RegisterGraph::DO_NOT_CONSIDER.end()) {
            outs() << "  ";
            I.print(outs());
            outs() << "\n";
          }
          else
            outs() << "    (" << symbolMap.get(&I)->getName() << ")" << I.getName() << "\n";
        }
      }
    }
  }

  //TODO : features to be implemented in PR2
  //SSA is eliminated.
  //phi node is yet not deleted(assembly emitter will delete it),
  //but we ensure that every reg in phi nodes point to same registers.
  //  ex) __r3__.7 = phi [%__r3__.2, %BB1], [%__r3__.0, %BB2], [%__arg0__, %BB3]
  //  NOT) __r3__.7 = phi [%__r2__.2, %BB1], [%__r5__.0, %BB2], [%__arg0__, %BB3]
  
  //SSAElimination(M, symbolMap);

  //Emits the assembly.
  //If the outputFile is given as "-", print it in the console.
  //Else, print it to the designated file.
  error_code EC;
  raw_ostream *os =
    outputFile == "-" ? &outs() : new raw_fd_ostream(outputFile, EC);

  if (EC) {
    errs() << "Cannot open file: " << outputFile << "\n";
    exit(1);
  }

  AssemblyEmitter Emitter(os, TM, symbolMap, spOffsetMap);
  for(Function& F : M){
    if(F.isDeclaration()) continue;
    Emitter.visit(F);
    *os << "end " << symbolMap.get(&F)->getName() << "\n";
  }

  if (os != &outs()) delete os;

  return PreservedAnalyses::all();
}

map<Function*, unsigned> Backend::processAlloca(Module& M, SymbolMap& SM) {

  map<Function*, unsigned> spOffsetMap;

  for(Function& F : M) {
    BasicBlock& entry = F.getEntryBlock();

    //Process alloca instructions which are only in the entry block.
    //acc: total stack accumulation of a function before an alloca inst.
    unsigned acc = 0;
    for(Instruction& I : entry) {

      AllocaInst* alloca = dyn_cast<AllocaInst>(&I);
      if(alloca) {
        //Update SymbolMap.
        Memory* stackaddr = new Memory(TM.sp(), acc);
        SM.set(alloca, stackaddr);
        SM.coallocateSameValues(alloca, stackaddr);
        //Update acc
        acc += getAccessSize(alloca->getAllocatedType());
      }
    }

    spOffsetMap[&F] = acc;
  }

  return spOffsetMap;
}
 
//---------------------------------------------------------------
//class SymbolMap
//---------------------------------------------------------------

SymbolMap::SymbolMap(Module* M, TargetMachine TM) : M(M), TM(TM) {
  //Initiate Machine symbols.

  RegisterGraph RG(*M);

  for(Function& F : *M) {
    assert(F.hasName() && "All functions in module should be named");
    symbolTable[&F] = new Func(F.getName());

    unsigned unnamedBB = 0;

    //Assign registers for arguments
    int i = 0;
    for(Value& arg : F.args()) {
      symbolTable[&arg] = TM.arg(i);
      coallocateSameValues(&arg, TM.arg(i));
      i++;
    }

    //Assign registers for instructions
    for(BasicBlock& BB : F) {

      symbolTable[&BB] = new Block(BB.hasName() ? BB.getName().str() : "_defaultBB" + to_string(unnamedBB++));

      for(Instruction& I : BB) {
        //If not colored(alloca and its derivatives), do nothing.
        if(RG.findValue(&I) == -1) continue;

        unsigned c = RG.getValueToColor(&F, &I);
        Symbol* s = TM.reg(c);
        symbolTable[&I] = s;

      }
    }
  }

  //Assign registers for Global variables
  unsigned acc = 0; //accumulated offset from the gvp pointer
  for(Value& gv : M->globals()) {
    if(!isa<GlobalVariable>(gv)) continue;
    unsigned size = getAccessSize(dyn_cast<GlobalVariable>(&gv)->getValueType());
    Memory* gvaddr = new Memory(TM.gvp(), acc);
    symbolTable[&gv] = gvaddr;
    coallocateSameValues(&gv, gvaddr);
    acc += size;
  }
}

void SymbolMap::set(Value* value, Symbol* symbol) {
  symbolTable[value] = symbol;
}

Symbol* SymbolMap::get(Value* value) {
  if(symbolTable.find(value) == symbolTable.end()) return nullptr;
  return symbolTable[value];
}

void SymbolMap::coallocateSameValues(Value* value, Symbol* symbol) {
  for(User* u : value->users()) {
    Instruction* I = dyn_cast<Instruction>(u);
    //If u is an instruction && type declared in SAME_CONSIDER
    if(I && RegisterGraph::SAME_CONSIDER.find(I->getOpcode()) != RegisterGraph::SAME_CONSIDER.end()) {
      symbolTable[I] = symbol;
    }
  }
}

} //end namespace backend