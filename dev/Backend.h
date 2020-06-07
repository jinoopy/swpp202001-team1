#ifndef BACKEND_H
#define BACKEND_H

#include "llvm/IR/PassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"

#include "LivenessAnalysis.h"
#include "RegisterSpill.h"

#include <string>
#include <queue>
#include <set>

using namespace llvm;
using namespace std;
using namespace backend;

namespace backend {

//---------------------------------------------------------------
//backend/TargetMachine.cpp
//---------------------------------------------------------------

class Symbol{
protected:
  friend TargetMachine;
  string name;
  Symbol() = default;
  Symbol(string name): name(name) {}
public:
  string getName();
};
//Hardware registers
class Register : public Symbol {
public:
  Register(StringRef name): Symbol(name) {}
};
//Memory addresses(GV, )
class Memory : public Symbol {
  Register* base;
  int64_t offset;
public:
  Memory(Register* base, int64_t offset);
  Register* getBase();
  int64_t getoffset();
};

class TargetMachine {
  Register* regfile[16];
  Register* argfile[16];
  Register* spreg;
  Register* gvpreg;

public:
  //Read-only getters for the register data stored in TargetMachine object.
  Register* reg(unsigned index);
  Register* arg(unsigned index);
  Register* sp();
  Register* gvp();

  //Checks the validity of the given symbol within the machine.
  bool valid(Symbol* symbol);
  
  //Initializes the target machine.
  TargetMachine();
};

//---------------------------------------------------------------
//backend/AssemblyEmitter.cpp
//---------------------------------------------------------------

class AssemblyEmitter {
  raw_ostream *fout;
public:
  AssemblyEmitter(raw_ostream *fout) : fout(fout) {}
  void run(Module *M);
};

//---------------------------------------------------------------
//backend/Backend.cpp
//---------------------------------------------------------------

class SymbolMap {
  //The target module to rename.
  Module* M;
  //Maps every value(GV, arg, reg) to a new symbol defined in the TargetMachine.
  map<Value*, Symbol*> symbolTable;
  //Target Machine model of our target.
  TargetMachine TM;

public:
  //Initializes the symbolTable.
  //Every register/memory stored values(GV, insts, args) are mapped to register.
  //Allocas are allocated a bit after.
  SymbolMap(Module*, TargetMachine&, RegisterGraph&);

  //interface for indirect access to symbolTable.
  void set(Value*, Symbol*);
  Symbol* get(Value*);

  //FIXME: This function should be private and friended to Backend::processAlloca.
  // - friend void Backend::processAlloca(Module& M, SymbolMap& SM);
  //However, it produces an unsolvable error, so it is set public for now.
  //Do not use this function elsewhere.
  void coallocateSameValues(Value*, Symbol*);
};

class Backend : public PassInfoMixin<Backend> {
  //File to print assembly (.s).
  string outputFile;
  //if true, prints the intermediate steps.
  bool printProcess;
  //Model for the target machine of our project.
  //Contains information about register files and 
  TargetMachine TM;  

public:

  Backend(string outputFile, bool printProcess = false) :
      outputFile(outputFile), printProcess(printProcess), TM() {}
  
  //runs the backend, which emits the assembly to given .s file.
  PreservedAnalyses run(Module &M, ModuleAnalysisManager &MAM);

  //SymbolMap initially does not mark alloca and its derivatives.
  //processing should be seperately done.
  map<Function*, unsigned> processAlloca(Module& M, SymbolMap& SM);

  void SSAElimination(Module &, SymbolMap &, RegisterGraph &);
  void addEdges(BasicBlock &, BasicBlock &, SymbolMap &, vector<vector<Symbol *>> &);
  Value *findLeastReg(Symbol *, BasicBlock &, SymbolMap &);
};

//Function which returns the byte size of a Type.
//brought from SimpleBackend(from repo swpp202001-compiler).
unsigned getAccessSize(Type *T);

} //end namespace backend

#endif