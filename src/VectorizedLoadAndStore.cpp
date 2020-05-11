#include "VectorizedLoadAndStore.h"

#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/PatternMatch.h"
#include "llvm/IR/Instructions.h"

#include <map>
#include <set>
#include <algorithm>

using namespace llvm;
using namespace std;

namespace optim {

PreservedAnalyses VectorizedLoadAndStorePass::run(Function &F, FunctionAnalysisManager &AM) {
	// 총 세 번 반복

	for(BasicBlock &BB : F) {
		vectorize(BB);
	}

	return PreservedAnalyses::all();
}

void VectorizedLoadAndStorePass::vectorize(BasicBlock& BB) {

	// IMPORTANT:
	// we assume that no same instruction exists in BB by GVN / GCSE passes.
	// e.g. %x = gep %ptr, 0
	//      %y = gep %ptr, 0 => NOT ALLOWED
	// e.g. %x = add %i, 1
	//      %y = add %i, 1 => NOT ALLOWED

	// %x = add %y, %1인 (%x, %y)를 찾아 ordering함
	for(vector<Instruction *> indvars : findIndvars(BB)) {
		map<Instruction *, unsigned> orderIndvars;
		for(int i = 0; i < indvars.size(); i++) {
			orderIndvars[indvars[i]] = i;
		}

		// 모든 size에 대해서,
		for(unsigned bits = 8; bits <= 32; bits << 1) {
			// GEP instruction 중 bits에 대응하는 pointer(8 -> i8*)를 찾아옴
			vector<GetElementPtrInst *> GEPs = findGEPs(BB, bits);
			vector<GetElementPtrInst *> orderGEPs(indvars.size());
			for(GetElementPtrInst *GEP : GEPs) {
				// finds the least significant index
				// e.g. arr[x][y][z], z is returned
				Instruction *last_index = dyn_cast<Instruction>(GEP->getOperand(GEP->getNumOperands() - 1));
				// if the last index is not an instruction, do not consider(indvar must be instruction)
				if(!last_index)
					continue;

				// if last_index is in current list of induction variables,
				if(orderIndvars.find(last_index) != orderIndvars.end()) {
					// order the GEPs
					assert(orderGEPs[orderIndvars[last_index]] == nullptr
						&& "equal instruction error; refer to the comment in VectorizedLoadAndStorePass::vectorize()");
					orderGEPs[orderIndvars[last_index]] = GEP;
				}
			}

			// group load and store if possible
			for(int i = 0; i < orderGEPs.size() - 1; i++) {
				// find all loads and stores for first & second GEP
				auto firstGEP = orderGEPs[i];
				vector<LoadInst *> firstGEPloads;
				vector<StoreInst *> firstGEPstores;
				auto secondGEP = orderGEPs[i+1];
				vector<LoadInst *> secondGEPloads;
				vector<StoreInst *> secondGEPstores;
				for(auto &I : BB) {
					LoadInst *lI = dyn_cast<LoadInst>(&I);
					StoreInst *stI = dyn_cast<StoreInst>(&I);
					// if I : LoadInst
					if(lI) {
						if(lI->getPointerOperand() == firstGEP) {
							firstGEPloads.push_back(lI);
						}
						if(lI->getPointerOperand() == secondGEP) {
							secondGEPloads.push_back(lI);
						}
					}
					// if I : storeInst
					if(stI) {
						if(stI->getPointerOperand() == firstGEP) {
							firstGEPstores.push_back(stI);
						}
						if(stI->getPointerOperand() == secondGEP) {
							secondGEPstores.push_back(stI);
						}
					}
				}

				// IMPORTANT: VERY dangerous assumption made here.
				// we consider that two corresponding nodes directly can be vectorized.
				// we have to analyze more through the behavior of loop unroll pass.
				assert(firstGEPloads.size() == secondGEPloads.size());
				assert(firstGEPstores.size() == secondGEPstores.size());

				for(int j = 0; j < firstGEPloads.size(); j++) {
					vectorizeLoads(firstGEP, firstGEPloads[i], secondGEPloads[i], BB, bits);
				}
				for(int j = 0; j < firstGEPstores.size(); j++) {
					vectorizeStores(firstGEP, firstGEPstores[i], secondGEPstores[i], BB, bits);
				}
			}
		}
	}
}

vector<vector<Instruction *>> VectorizedLoadAndStorePass::findIndvars(BasicBlock &BB) {
	vector<vector<Instruction *>> insts;
	for(Instruction &I : BB) {
		insts.push_back(vector<Instruction *>( {&I} ));
	}
	for(Instruction &I : BB) {
		BinaryOperator *addI = dyn_cast<BinaryOperator>(&I);
		if(addI && addI->getOpcode() == Instruction::Add) {
			// if I is an Add instruction,
			// bring two operands from I.
			auto *op1 = addI->getOperand(0);
			auto *op2 = addI->getOperand(1);

			Constant *C1 = dyn_cast<Constant>(op1);
			Constant *C2 = dyn_cast<Constant>(op2);

			// if op1 is constant 1,
			if(C1 && C1->getUniqueInteger() == 1) {
				// find a list that begins with operand(%x) and result(%y).
				vector<Instruction *> *indvar1, *indvar2;
				for(auto it : insts) {
					if(it.size() > 0 && it[0] == op2) {
						indvar1 = &it;
					} else if(it.size() > 0 && it[0] == addI) {
						indvar2 = &it;
					}
				}
				// append %y to %x, so that %y comes later than %x in single list.
				indvar1->insert(indvar1->begin(), indvar2->begin(), indvar2->end());
			} else if(C2 && C2->getUniqueInteger() == 1) { // if op2 is constant 1
				// find a list that begins with operand(%x) and result(%y).
				vector<Instruction *> *indvar1, *indvar2;
				for(auto it : insts) {
					if(it.size() > 0 && it[0] == op1){
						indvar1 = &it;
					} else if(it.size() > 0 && it[0] == addI) {
						indvar2 = &it;
					}
				}
				// append %y to %x, so that %y comes later than %x in single list.
				indvar1->insert(indvar1->begin(), indvar2->begin(), indvar2->end());
			}
		}
	}
	for(auto it = insts.begin(); it != insts.end();) {
		if(it->size() < 2) {
			it = insts.erase(it);
		} else {
			++it;
		}
	}
	return insts;
}

vector<GetElementPtrInst *> VectorizedLoadAndStorePass::findGEPs(BasicBlock &BB, unsigned size) {
	LLVMContext &Context = BB.getContext();

	vector<GetElementPtrInst *> GEPs;
	Type *ptrType;
	switch(size) {
		case 8:
			ptrType = Type::getInt8PtrTy(Context);
			break;
		case 16:
			ptrType = Type::getInt16PtrTy(Context);
			break;
		case 32:
			ptrType = Type::getInt32PtrTy(Context);
			break;
		default:
			assert(false && "must not reach, size should be one from 8, 16, 32");
	}
	for(Instruction &I : BB) {
		GetElementPtrInst *GEP = dyn_cast<GetElementPtrInst>(&I);
		if(GEP != nullptr && GEP->getResultElementType() == ptrType) {
			GEPs.push_back(GEP);
		}
	}
	return GEPs;
}

void VectorizedLoadAndStorePass::vectorizeLoads(GetElementPtrInst *GEPI, LoadInst *LI1, LoadInst *LI2, BasicBlock &BB, unsigned) {
	//TODO
	//Merge and replace two LoadInsts given to one.
	//the merged load should be done in the result of GEP.
}

void VectorizedLoadAndStorePass::vectorizeStores(GetElementPtrInst *GEPI, StoreInst *LI1, StoreInst *LI2, BasicBlock &BB, unsigned) {
	//TODO
	//Merge and replace two StoreInsts given to one.
	//the merged store should be done in the result of GEP.
}

}