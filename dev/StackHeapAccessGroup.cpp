#include "StackHeapAccessGroup.h"

using namespace llvm;
using namespace std;
using namespace llvm::PatternMatch;

namespace optim {

AllocType getBlockType(const Value *V) {
	if(auto *CI = dyn_cast<CallInst>(V)) {
		if(CI->getCalledFunction()->getName() == "malloc") {
			return HEAP;
		}
	} else if(auto *AI = dyn_cast<AllocaInst>(V)) {
		return STACK;
	} else if(auto *BI = dyn_cast<BitCastInst>(V)) {
		return getBlockType(BI->getOperand(0));
	} else if(auto *GI = dyn_cast<GetElementPtrInst>(V)) {
		return getBlockType(GI->getPointerOperand());
	}
	return UNKNOWN;
}

PreservedAnalyses StackHeapAccessGroupPass::run(Function &F, FunctionAnalysisManager &FAM) {
	if(F.isDeclaration()) {
		return PreservedAnalyses::all();
	}
	map<BasicBlock *, AllocType> lastAccessType;
	DominatorTree DT(F);

	for(BasicBlock &BB : F) {
		map<Instruction *, vector<Instruction *>> adjacentList;
		map<Instruction *, int> indegree;
		set<Instruction *> instSet;

		// For debugging
		map<Instruction *, int> indexOfInst;

		for(Instruction &I : BB) {
			adjacentList.emplace(&I, vector<Instruction *>());
			indegree.emplace(&I, 0);
			instSet.insert(&I);
		}

		int index = 0;
		for(Instruction &I1 : BB) {
			indexOfInst[&I1] = ++index;

			if(I1.isTerminator()) {
				for(Instruction &I2 : BB) {
					if(&I1 != &I2) {
						adjacentList[&I2].push_back(&I1);
						indegree[&I1]++;
					}
				}
				break;
			}

			if(auto *LI = dyn_cast<LoadInst>(&I1)) {
				for(Instruction &I2 : BB) {
					if(&I1 == &I2) {
						break;
					}
					if(auto *SI = dyn_cast<StoreInst>(&I2)) {
						if(SI->getPointerOperand() != LI->getPointerOperand()) {
							continue;
						}
						indegree[&I1]++;
						adjacentList[&I2].push_back(&I1);
					}
				}	
			} else if(auto *SI = dyn_cast<StoreInst>(&I1)) {
				for(Instruction &I2 : BB) {
					if(&I1 == &I2) {
						break;
					}
					if(auto *LI = dyn_cast<LoadInst>(&I2)) {
						if(SI->getPointerOperand() != LI->getPointerOperand()) {
							continue;
						}
						indegree[&I1]++;
						adjacentList[&I2].push_back(&I1);
					}
				}
			}

			Use *operandList = I1.getOperandList();
			for(unsigned i = 0; i < I1.getNumOperands(); i++) {
				Value *value = I1.getOperand(i);
				Instruction *valueToInst = dyn_cast<Instruction>(value);
				if(valueToInst && instSet.find(valueToInst) != instSet.end()) {
					indegree[&I1]++;
					adjacentList[valueToInst].push_back(&I1);
				}
			}
		}

		set<Instruction *> heapAccess, stackAccess;

		for(Instruction &I : BB) {
			AllocType type;
			if(auto *SI = dyn_cast<StoreInst>(&I)) {
				type = getBlockType(SI->getPointerOperand());
			} else if(auto *LI = dyn_cast<LoadInst>(&I)) {
				type = getBlockType(LI->getPointerOperand());
			} else {
				type = AllocType::UNKNOWN;
			}

			if(type == AllocType::HEAP) {
				heapAccess.insert(&I);
			} else if(type == AllocType::STACK) {
				stackAccess.insert(&I);
			}
		}

		if(heapAccess.size() == 0 && stackAccess.size() == 0) {
			lastAccessType.emplace(&BB, AllocType::UNKNOWN);
			continue;
		}

		vector<Instruction *> heapFirst, stackFirst;
		int heapFirstCost, stackFirstCost;

		heapFirstCost = getTopologicalSort(adjacentList, indegree, heapAccess, stackAccess, AllocType::HEAP, heapFirst, indexOfInst);
		stackFirstCost = getTopologicalSort(adjacentList, indegree, heapAccess, stackAccess, AllocType::STACK, stackFirst, indexOfInst);

		pred_iterator PI = pred_begin(&BB), E = pred_end(&BB);
		bool heapExist = false, stackExist = false;

		for(; PI != E; PI++) {
			AllocType predAlloc = lastAccessType[*PI];
			if(predAlloc == AllocType::STACK) {
				stackExist = true;
			} else if(predAlloc == AllocType::HEAP) {
				heapExist = true;
			}
		}

		if(heapExist ^ stackExist) {
			heapFirstCost += stackExist;
			stackFirstCost += heapExist;
		}

		vector<Instruction *> *finalState;

		if(heapFirstCost < stackFirstCost) {
			finalState = &heapFirst;
		} else {
			finalState = &stackFirst;
		}

		AllocType lastAccess;
		for(auto &I : *finalState) {
			if(auto *SI = dyn_cast<StoreInst>(I)) {
				lastAccess = getBlockType(SI->getPointerOperand());
			} else if(auto *LI = dyn_cast<LoadInst>(I)) {
				lastAccess = getBlockType(LI->getPointerOperand());
			}
		}
		lastAccessType.emplace(&BB, lastAccess);

		for(auto &I : *finalState) {
			I->removeFromParent();
		}

		IRBuilder builder(&BB);

		for(auto &I : *finalState) {
			builder.Insert(I);
		}
	}
	return PreservedAnalyses::all();
}

int StackHeapAccessGroupPass::getTopologicalSort(map<Instruction *, vector<Instruction *>> &adjacentList, map<Instruction *, int> indegree, 
							set<Instruction *> &heapAccess, set<Instruction *> &stackAccess, AllocType firstType,
							vector<Instruction *> &result, map<Instruction *, int> &indexOfInst) {
		
		assert(firstType != AllocType::UNKNOWN && "Invalid function call: AllocType value is AllocType::UNKNOWN");
		
		queue<Instruction *> q;
		set<Instruction *> visited;

		int resetCount = 0;

		AllocType canTraverse = firstType;
		unsigned instCount = indegree.size();

		while(result.size() < instCount) {
			for(auto &inst : indegree) {
				if(inst.second == 0 && visited.find(inst.first) == visited.end()) {
					if(auto *SI = dyn_cast<StoreInst>(inst.first)) {
						if(getBlockType(SI->getPointerOperand()) != canTraverse) {
							continue;
						}
					} else if(auto *LI = dyn_cast<LoadInst>(inst.first)) {
						if(getBlockType(LI->getPointerOperand()) != canTraverse) {
							continue;
						}
					}
					q.push(inst.first);
				}
			}

			while(!q.empty()) {
				Instruction *inst = q.front();
				q.pop();
				visited.insert(inst);
				result.push_back(inst);

				for(auto &there : adjacentList[inst]) {
					if(!--indegree[there]) {
						AllocType type = AllocType::UNKNOWN;
						
						if(auto *SI = dyn_cast<StoreInst>(there)) {
							type = getBlockType(SI->getPointerOperand());
						} else if(auto *LI = dyn_cast<LoadInst>(there)) {
							type = getBlockType(LI->getPointerOperand());
						}

						if(type == AllocType::UNKNOWN || type == canTraverse) {
							q.push(there);
						}
					}
				}
			}

			canTraverse = (canTraverse == AllocType::HEAP ? AllocType::STACK : AllocType::HEAP);
			resetCount++;
		}

		return --resetCount;
	}

}