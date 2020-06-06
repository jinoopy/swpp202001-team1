#include "StackHeapAccessGroup.h"

using namespace llvm;
using namespace std;
using namespace llvm::PatternMatch;

namespace optim {

// This function returns allocated memory area of Value V.
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
	// Store last accessed memory area for each basic block.
	map<BasicBlock *, AllocType> lastAccessType;
	DominatorTree DT(F);

	for(BasicBlock &BB : F) {
		// adjacentList: adjacent list to represent graph
		// indegree: the number of incoming edges for each vertex
		// instSet: set of instructions in the basic block
		map<Instruction *, vector<Instruction *>> adjacentList;
		map<Instruction *, int> indegree;
		set<Instruction *> instSet;

		// For debugging. Store index for each instruction
		map<Instruction *, int> indexOfInst;

		for(Instruction &I : BB) {
			adjacentList.emplace(&I, vector<Instruction *>());
			indegree.emplace(&I, 0);
			instSet.insert(&I);
		}

		int index = 0;
		for(Instruction &I1 : BB) {
			indexOfInst[&I1] = ++index;

			// Terminator instruction (s.t. ret, br) has incoming edge from every instruction.
			if(I1.isTerminator()) {
				for(Instruction &I2 : BB) {
					if(&I1 != &I2) {
						adjacentList[&I2].push_back(&I1);
						indegree[&I1]++;
					}
				}
				break;
			}

			// If I1 is LoadInst, then it has edges from StoreInsts with same pointer operand.
			if(auto *LI = dyn_cast<LoadInst>(&I1)) {
				for(Instruction &I2 : BB) {
					if(&I1 == &I2) {
						break;
					}
					// Make edge between LoadInst and StoreInst if two have same pointer operand.
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
				// If below condition is false, it means ith operand is constant or instruction 
				// from other basic blocks. 
				if(valueToInst && instSet.find(valueToInst) != instSet.end()) {
					indegree[&I1]++;
					adjacentList[valueToInst].push_back(&I1);
				}
			}
		}

		// set of instructions with heap/stack access
		set<Instruction *> heapAccess, stackAccess;

		// Investigate access memory area, and insert into proper set.
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

		// Both size of set are zero -> BB has no memory access
		if(heapAccess.size() == 0 && stackAccess.size() == 0) {
			lastAccessType.emplace(&BB, AllocType::UNKNOWN);
			continue;
		}

		// Store results from heap/stack first topological sort.
		vector<Instruction *> heapFirst, stackFirst;
		int heapFirstCost, stackFirstCost;

		heapFirstCost = getTopologicalSort(adjacentList, indegree, heapAccess, stackAccess, AllocType::HEAP, heapFirst, indexOfInst);
		stackFirstCost = getTopologicalSort(adjacentList, indegree, heapAccess, stackAccess, AllocType::STACK, stackFirst, indexOfInst);

		// Iterator to traverse predecessors and find last accessed memory area for each basic block
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

		// Below condition is true when predecessor has only one type of area as last accessed memory area.
		if(heapExist ^ stackExist) {
			// If stackExist is true, then heapFirstCost should increase by 1 because heap
			// access is following after stack access. Same as heapExist and stackFirstCost.
			heapFirstCost += stackExist;
			stackFirstCost += heapExist;
		}

		vector<Instruction *> *finalState;

		// Choose result with lower cost as an optimal order.
		if(heapFirstCost < stackFirstCost) {
			finalState = &heapFirst;
		} else {
			finalState = &stackFirst;
		}

		// Find last store/load instruction in the optimal order.
		AllocType lastAccess;
		for(auto &I : *finalState) {
			if(auto *SI = dyn_cast<StoreInst>(I)) {
				lastAccess = getBlockType(SI->getPointerOperand());
			} else if(auto *LI = dyn_cast<LoadInst>(I)) {
				lastAccess = getBlockType(LI->getPointerOperand());
			}
		}
		lastAccessType.emplace(&BB, lastAccess);

		// Remove all instructions from BB and reconstruct from using IRBuilder.	
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

// This function returns result of topological sort, with initial preference to heap/stack access.
int StackHeapAccessGroupPass::getTopologicalSort(map<Instruction *, vector<Instruction *>> &adjacentList, map<Instruction *, int> indegree, 
							set<Instruction *> &heapAccess, set<Instruction *> &stackAccess, AllocType firstType,
							vector<Instruction *> &result, map<Instruction *, int> &indexOfInst) {
	// AllocType::UNKNOWN cannot be initial preference.
	assert(firstType != AllocType::UNKNOWN && "Invalid function call: AllocType value is AllocType::UNKNOWN");

	queue<Instruction *> q;
	set<Instruction *> visited;

	int resetCount = 0;

	// canTraverse stores current preference(heap/stack)
	AllocType canTraverse = firstType;
	unsigned instCount = indegree.size();

	// Visit all vertices(instructions)
	while(result.size() < instCount) {
		for(auto &inst : indegree) {
			// If indegree is zero and not visited yet
			if(inst.second == 0 && visited.find(inst.first) == visited.end()) {
				// Check whether inst.first has same access memory area as canTraverse.
				if(auto *SI = dyn_cast<StoreInst>(inst.first)) {
					if(getBlockType(SI->getPointerOperand()) != canTraverse) {
						continue;
					}
				} else if(auto *LI = dyn_cast<LoadInst>(inst.first)) {
					if(getBlockType(LI->getPointerOperand()) != canTraverse) {
						continue;
					}
				}
				// Otherwise enqueue it.
				q.push(inst.first);
			}
		}

		// Topological sort with BFS
		while(!q.empty()) {
			Instruction *inst = q.front();
			q.pop();
			visited.insert(inst);
			result.push_back(inst);

			// For every outgoing edge, 
			for(auto &there : adjacentList[inst]) {
				// if there is a vertex which has any incoming edge, 
				if(!--indegree[there]) {
					AllocType type = AllocType::UNKNOWN;

					if(auto *SI = dyn_cast<StoreInst>(there)) {
						type = getBlockType(SI->getPointerOperand());
					} else if(auto *LI = dyn_cast<LoadInst>(there)) {
						type = getBlockType(LI->getPointerOperand());
					}

					// if memory access type is unknown or same as canTraverse
					// then enqueue it.
					if(type == AllocType::UNKNOWN || type == canTraverse) {
						q.push(there);
					}
				}
			}
		}

		// End of topological sort with preference(canTraverse).
		// Switch canTraverse to stack/heap and increase resetCount by 1.
		canTraverse = (canTraverse == AllocType::HEAP ? AllocType::STACK : AllocType::HEAP);
		resetCount++;
	}

	// Actual resetCount should be decreased by 1.
	return --resetCount;
}

}