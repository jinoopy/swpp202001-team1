
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

/*
  TODO : features to be implemented in PR2
  //SSA is eliminated.
  //phi node is yet not deleted(assembly emitter will delete it),
  //but we ensure that every reg in phi nodes point to same registers.
  //  ex) __r3__.7 = phi [%__r3__.2, %BB1], [%__r3__.0, %BB2], [%__arg0__, %BB3]
  //  NOT) __r3__.7 = phi [%__r2__.2, %BB1], [%__r5__.0, %BB2], [%__arg0__, %BB3]
  */
  SSAElimination(M, symbolMap);
  
  if (verifyModule(M, &errs(), nullptr)) {
    errs() << "BUG: SSAElimination created an ill-formed module!\n";
    errs() << M;
    exit(1);
  }
/*
  // For debugging, this will print the depromoted module.
  if (printDepromotedModule)*/
    M.print(outs(), nullptr);/*

  // Now, let's emit assembly!
  error_code EC;
  raw_ostream *os =
    outputFile == "-" ? &outs() : new raw_fd_ostream(outputFile, EC);

  if (EC) {
    errs() << "Cannot open file: " << outputFile << "\n";
    exit(1);
  }

  AssemblyEmitter Emitter(os);
  Emitter.run(M);

  if (os != &outs()) delete os;
*/
  return PreservedAnalyses::all();
}

// Author: Deokin Jeong (Code style may be different)
// For each basic block, construct a directed graph from branch instruction and phi nodes.
// If we reverse direction of all edges in graph, then graph forms a functional graph.
// Cause every vertex of functional graph has only one outgoing edge, it is easier to 
// traverse graph.
// Graph traverse starts from vertex without an incoming edge, and ends to loop.
// If we detect a loop, there are two options for this.
//   (i)  If there is not used (physical) register, then use it as temporary register to 
//        move values.
//   (ii) Otherwise, just repeat (xor)swapping two registers.
// Following function implements above explanation.
void Backend::SSAElimination(Module &M, SymbolMap &symbolMap) {
	for(Function &F : M) {
		if(F.isDeclaration()) {
			continue;
		}
		for(BasicBlock &BB : F) {
			LLVMContext &Context = BB.getContext();
			// To represent graph, following vector(adjacent list) is used.
			vector<vector<int>> adjList(16);
			BranchInst *brInst = dyn_cast<BranchInst>(BB.getTerminator());
			// If terminator is return statement, then pass it.
			if(brInst == nullptr) {
				continue;
			}
			// For every successor, find phi nodes from BB and construct graph.
			for(unsigned i = 0; i < brInst->getNumSuccessors(); i++) {
				addEdges(BB, *(brInst->getSuccessor(i)), symbolMap, adjList);
			}

			// To store the number of incoming edge.
			// If there is u -> v edge in graph, it means the value of register v
			// should move to register u.
			vector<unsigned> indegree(16, 0);
			set<int> unused;
			for(unsigned i = 0; i < 16; i++) {
				for(int &there : adjList[i]) {
					indegree[there]++;
				}
				// If a register has no outgoing edge, store and use as temporary register.
				if(adjList[i].size() == 0) {
					unused.insert(i);
				}
			}
			
			// countRest represents the number of untracked vertices, 
			// but this is useless (until now).
			int countRest = 16 - (int)unused.size();

			// Use queue to traverse graph (but not so necessary)
			queue<unsigned> q;
			for(unsigned i = 0; i < 16; i++) {
				if(!indegree[i] && unused.find(i) == unused.end()) {
					q.push(i);
				}
			}

			while(!q.empty()) {
				unsigned curReg = q.front();
				q.pop();
				countRest--;
				if(adjList[curReg].empty()) {
					break;
				}
				// findLeastReg() finds endmost register which is allocated to r(adjList[curReg][0]). 
				Value *value = findLeastReg(adjList[curReg][0], BB, symbolMap);
				
				// Create new Mul instruction to move value to curReg.
				// TODO: Fix below APInt(32, 1) to proper data type.
				Instruction *moveInst = BinaryOperator::CreateMul(value, ConstantInt::get(Context, APInt(32, 1)));
				moveInst->insertBefore(BB.getTerminator());
				symbolMap.set(dyn_cast<Value>(moveInst), TM.reg(curReg));
				
				if(!--indegree[adjList[curReg][0]]) {
					q.push(adjList[curReg][0]);
				}
			}

			// countRest is under 1 if graph has no loop or only one self loop.
			if(countRest <= 1) {
				continue;
			} else if(unused.size() > 0) { // There is an extra register to use.
				int registerNum = *unused.begin();
				for(unsigned i = 0; i < 16; i++) {
					// indegree[i] > 0 means register i is part of the loop.
					if(indegree[i] > 0) {
						// Move the value of register i to temporary register.
						q.push(i);
						Value *value = findLeastReg(i, BB, symbolMap);
						Instruction *moveToTemp = BinaryOperator::CreateMul(value, ConstantInt::get(Context, APInt(32, 1)));
						moveToTemp->insertBefore(BB.getTerminator());
						symbolMap.set(dyn_cast<Value>(moveToTemp), TM.reg(registerNum));
						unsigned lastQueue;
						// Move the value in the loop.
						while(!q.empty()) {
							unsigned curReg = q.front();
							q.pop();
							countRest--;
							if(adjList[curReg][0] == i) {
								lastQueue = curReg;
								break;
							}
							Value *nextValue = findLeastReg(adjList[curReg][0], BB, symbolMap);
							Instruction *moveInst = BinaryOperator::CreateMul(nextValue, ConstantInt::get(Context, APInt(32, 1)));
							moveInst->insertBefore(BB.getTerminator());
							symbolMap.set(dyn_cast<Value>(moveInst), TM.reg(curReg));
							if(!--indegree[adjList[curReg][0]]) {
								q.push(adjList[curReg][0]);
							}
						}
						// At the end, move a value of temporary register to a register before register i.
						Instruction *moveFromTemp = BinaryOperator::CreateMul(dyn_cast<Value>(moveToTemp), ConstantInt::get(Context, APInt(64, 1)));
						moveFromTemp->insertBefore(BB.getTerminator());
						symbolMap.set(dyn_cast<Value>(moveFromTemp), TM.reg(lastQueue));

						// Cause the graph can have at most 2 loops, so continue to traverse.
					}
				}
			} else {
				// Swap two adjacent registers.
				for(unsigned i = 0; i < 16; i++) {
					if(indegree[i] > 0) {
						q.push(i);
						Value *startValue = findLeastReg(i, BB, symbolMap);
						while(!q.empty()) {
							unsigned curReg = q.front();
							q.pop();

							if(adjList[curReg].empty() || adjList[curReg][0] == i) {
								break;
							}

							Value *nextValue = findLeastReg(adjList[curReg][0], BB, symbolMap);

							// XOR swapping
							Instruction *xor1 = BinaryOperator::CreateXor(startValue, nextValue);
							xor1->insertBefore(BB.getTerminator());
							symbolMap.set(dyn_cast<Value>(xor1), TM.reg(adjList[curReg][0]));

							Instruction *xor2 = BinaryOperator::CreateXor(startValue, dyn_cast<Value>(xor1));
							xor2->insertBefore(BB.getTerminator());
							symbolMap.set(dyn_cast<Value>(xor2), TM.reg(curReg));

							Instruction *xor3 = BinaryOperator::CreateXor(dyn_cast<Value>(xor1), dyn_cast<Value>(xor2));
							xor3->insertBefore(BB.getTerminator());
							symbolMap.set(dyn_cast<Value>(xor3), TM.reg(adjList[curReg][0]));

							if(!--indegree[adjList[curReg][0]]) {
								q.push(adjList[curReg][0]);
								startValue = dyn_cast<Value>(xor3);
							}
						}
					}
				}
			}
		}
	}
}

// This function finds endmost register which is allocated to register i. 
Value *Backend::findLeastReg(unsigned i, BasicBlock &BB, SymbolMap &symbolMap) {
	Value *returnValue = nullptr;
	for(Instruction &I : BB) {
		Symbol *symbol = symbolMap.get(dyn_cast<Value>(&I));
		// "r" + itostr(i) == "r{i}"
		if(symbol && symbol->getName() == "r" + itostr(i)) {
			returnValue = dyn_cast<Value>(&I);
		}
	}
	return returnValue;
}

// This function finds edges between two basic blocks(srcBB, dstBB).
void Backend::addEdges(BasicBlock &srcBB, BasicBlock &dstBB, SymbolMap &symbolMap, vector<vector<int>> &adjList) {
	for(Instruction &I : dstBB) {
		PHINode *phi = dyn_cast<PHINode>(&I);
		if(phi == nullptr) {
			continue;
		}
		// Only phi nodes
		bool findSrc = false;
		Symbol *phiSymbol = symbolMap.get(dyn_cast<Value>(&I));
		if(phiSymbol == nullptr) {
			continue;
		}
		string phiName = phiSymbol->getName();
		// phiName = "r{i}" -> stoi(substr(1)) = i
		int phiNum = stoi(phiName.substr(1));
		for(unsigned i = 0; i < phi->getNumIncomingValues(); i++) {
			BasicBlock *from = phi->getIncomingBlock(i);
			if(&srcBB != from) {
				continue;
			}
			// Only srcBB
			findSrc = true;
			Symbol *instSymbol = symbolMap.get(phi->getIncomingValue(i));
			if(instSymbol == nullptr) {
				continue;
			}
			string instName = instSymbol->getName();
			int instNum = stoi(instName.substr(1));
			// phiNum == instNum -> self loop, ignore it (because it is useless)
			if(phiNum == instNum) {
				continue;
			}
			adjList[phiNum].push_back(instNum);
		}
	}
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

    //Assign registers for arguments
    int i = 0;
    for(Value& arg : F.args()) {
      symbolTable[&arg] = TM.arg(i);
      coallocateSameValues(&arg, TM.arg(i));
      i++;
    }

    //Assign registers for instructions
    for(auto it = inst_begin(&F); it != inst_end(&F); ++it) {
      Instruction& I = *it;

      //If not colored(alloca and its derivatives), do nothing.
      if(RG.findValue(&I) == -1) continue;

      unsigned c = RG.getValueToColor(&F, &I);
      Symbol* s = TM.reg(c);
      symbolTable[&I] = s;
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