#include "VectorizedLoadAndStore.h"

#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/PatternMatch.h"
#include "llvm/IR/Instructions.h"

#include <map>
#include <set>
#include <algorithm>
#include <vector>
#include <iostream>

using namespace llvm;
using namespace std;

namespace optim {

PreservedAnalyses VectorizedLoadAndStorePass::run(Function &F, FunctionAnalysisManager &AM) {
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

	// find %x = add %y, 1 and map to GEP
	for(vector<Instruction *> indvars : findIndvars(BB)) {
		map<Instruction *, unsigned> orderIndvars;
		for(int i = 0; i < indvars.size(); i++) {
			orderIndvars[indvars[i]] = i;
		}

		// for all bitwidth
		for(unsigned bits = 8; bits <= 32; bits <<= 1) {
			// GEP instruction 중 bits에 대응하는 pointer(8 -> i8*)를 찾아옴
			vector<GetElementPtrInst *> GEPs = findGEPs(BB, bits);
			map<Instruction *, vector<GetElementPtrInst *>> orderGEPs;
			// vector<GetElementPtrInst *> orderGEPs(indvars.size());
			for(GetElementPtrInst *GEP : GEPs) {
				// finds the least significant operand (index)
				// e.g. arr[x][y][z], z is returned
				Instruction *last_index = dyn_cast<Instruction>(GEP->getOperand(GEP->getNumOperands() - 1));
				Instruction *basePTR = dyn_cast<Instruction>(GEP->getPointerOperand());

				// if the last index is not an instruction, do not consider(indvar must be instruction)
				if(!last_index || !basePTR) {
					continue;
				}

				cout << "Hello" << endl;

				// if last_index is in current list of induction variables,
				if(orderIndvars.find(last_index) != orderIndvars.end()) {
					// assume same index accessing does not exist
					// assert(orderGEPs[orderIndvars[last_index]] == nullptr
					//	&& "equal instruction error; refer to the comment in VectorizedLoadAndStorePass::vectorize()");
					// map to GEP
					if(orderGEPs.find(basePTR) == orderGEPs.end()) {
						orderGEPs[basePTR] = vector<GetElementPtrInst *>(indvars.size());
					}

					orderGEPs[basePTR][orderIndvars[last_index]] = GEP;
				}
			}
			for(pair<Instruction *, vector<GetElementPtrInst *>> basePTR : orderGEPs) {
				for(int i = 0; i < basePTR.second.size() - 1; i+=2) {
					// find all loads and stores for first & second GEP
					auto firstGEP = basePTR.second[i];
					vector<LoadInst *> firstGEPloads;
					vector<StoreInst *> firstGEPstores;
					auto secondGEP = basePTR.second[i+1];
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
					if(firstGEPloads.size() != secondGEPloads.size() || firstGEPstores.size() != secondGEPstores.size()) {
						continue;
					}
					

					for(int j = 0; j < firstGEPloads.size(); j++) {
						vectorizeLoads(firstGEP, secondGEP, firstGEPloads[j], secondGEPloads[j], BB, bits);
					}
					for(int j = 0; j < firstGEPstores.size(); j++) {
						vectorizeStores(firstGEP, secondGEP, firstGEPstores[j], secondGEPstores[j], BB, bits);
					}
					secondGEP->eraseFromParent();
				}		
			}
		}
	}
}

// This function makes std::vector, which is consist of chain lists
// that are made by iterative add instruction of index.
vector<vector<Instruction *>> VectorizedLoadAndStorePass::findIndvars(BasicBlock &BB) {
	// insts will contain chain list of add instruction,
	// which is instruction on index.
	vector<vector<Instruction *>> insts;
	// cout << "Basic Block: " << BB.getName().str() << endl;
	for(Instruction &I : BB) {
		BinaryOperator *addI = dyn_cast<BinaryOperator>(&I);
		// to indicate whether current instruction is appeared already or not.
		bool firstAppear = 1;
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
				vector<Instruction *> *indvar1 = nullptr;
				for(auto &it : insts) {
					if(it.size() > 0 && it[it.size()-1] == op2) {
						indvar1 = &it;
					}
				}
				if(indvar1 != nullptr) {
					indvar1->push_back(&I);
					firstAppear = 0;
				}
			} else if(C2 && C2->getUniqueInteger() == 1) { // if op2 is constant 1
				// find a list that begins with operand(%x) and result(%y).
				vector<Instruction *> *indvar1 = nullptr;
				for(auto &it : insts) {
					if(it.size() > 0 && it[it.size()-1] == op1) {
						indvar1 = &it;
					}
				}
				if(indvar1 != nullptr) {
					indvar1->push_back(&I);
					firstAppear = 0;
				}
			}
		}
		if(firstAppear) {
			insts.push_back(vector<Instruction *>( {&I} ));
		}
	}
	int count = 0;
	// remove meaningless vector
	for(auto it = insts.begin(); it != insts.end();) {
		if(it->size() < 3) {
			count++;
			it = insts.erase(it);
		} else {
			++it;
		}
	}
	return insts;
}

// This function collects GetElementPtr Instruction of given pointer type of size in BB.
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
		if(GEP && GEP->getType() == ptrType) {
			GEPs.push_back(GEP);
		}
	}
	return GEPs;
}

// This function vectorize load instruction.
void VectorizedLoadAndStorePass::vectorizeLoads(GetElementPtrInst *GEPI, GetElementPtrInst *nextGEPI, LoadInst *LI1, LoadInst *LI2, BasicBlock &BB, unsigned bits) {
	LLVMContext &Context = BB.getContext();
	Type *ptrType, *numType, *numTypeOfBits;
	switch(bits) {
		case 8:
			ptrType = Type::getInt16PtrTy(Context);
			numType = Type::getInt16Ty(Context);
			numTypeOfBits = Type::getInt8Ty(Context);
			break;
		case 16:
			ptrType = Type::getInt32PtrTy(Context);
			numType = Type::getInt32Ty(Context);
			numTypeOfBits = Type::getInt16Ty(Context);
			break;
		case 32:
			ptrType = Type::getInt64PtrTy(Context);
			numType = Type::getInt64Ty(Context);
			numTypeOfBits = Type::getInt32Ty(Context);
			break;
		default:
			assert(false && "must not reach, size should be one from 8, 16, 32");
	}
	// bitcast to upper type to load once
	BitCastInst *castedGEPI = new BitCastInst(GEPI, ptrType);
	LoadInst *LI = new LoadInst(castedGEPI);
	castedGEPI->insertAfter(GEPI);
	LI->insertAfter(castedGEPI);

	// decompose loaded value into two value (X, Z)
	Instruction *X, *Y;
	X = BinaryOperator::CreateURem(LI, ConstantInt::get(Context, APInt(bits << 1, 1llu << bits, false)));
	TruncInst *XTrunc = new TruncInst(X, numTypeOfBits);
	Y = BinaryOperator::CreateUDiv(LI, ConstantInt::get(Context, APInt(bits << 1, 1llu << bits, false)));
	TruncInst *YTrunc = new TruncInst(Y, numTypeOfBits);

	// replace existing values with new values from vectorized load instruction
	LI1->replaceAllUsesWith(XTrunc);
	LI2->replaceAllUsesWith(YTrunc);

	// insert instruction properly
	X->insertAfter(LI);
	XTrunc->insertAfter(X);
	Y->insertAfter(XTrunc);
	YTrunc->insertAfter(Y);

	// remove useless instruction
	LI1->eraseFromParent();
	LI2->eraseFromParent();
	// nextGEPI->eraseFromParent();
}

// This function vectorize store function.
void VectorizedLoadAndStorePass::vectorizeStores(GetElementPtrInst *GEPI, GetElementPtrInst *nextGEPI, StoreInst *STI1, StoreInst *STI2, BasicBlock &BB, unsigned bits) {
	LLVMContext &Context = BB.getContext();
	Type *ptrType, *numType;
	switch(bits) {
		case 8:
			ptrType = Type::getInt16PtrTy(Context);
			numType = Type::getInt16Ty(Context);
			break;
		case 16:
			ptrType = Type::getInt32PtrTy(Context);
			numType = Type::getInt32Ty(Context);
			break;
		case 32:
			ptrType = Type::getInt64PtrTy(Context);
			numType = Type::getInt64Ty(Context);
			break;
		default:
			assert(false && "must not reach, size should be one from 8, 16, 32");
	}
	// bitcast to upper type to load once
	BitCastInst *castedGEPI = new BitCastInst(GEPI, ptrType);

	// concatenate two value into one to store once
	Instruction *X, *Y, *Z;
	ZExtInst *W1 = new ZExtInst(STI2->getValueOperand(), numType);
	ZExtInst *W2 = new ZExtInst(STI1->getValueOperand(), numType);
	castedGEPI->insertBefore(STI2);
	Y = BinaryOperator::CreateMul(W1, ConstantInt::get(Context, APInt(bits << 1, 1llu << bits, false)));
	Z = BinaryOperator::CreateOr(Y, W2);
	StoreInst *STI = new StoreInst(Z, castedGEPI);
	
	// insert instruction properly
	STI->insertAfter(castedGEPI);
	Z->insertBefore(STI);
	Y->insertBefore(Z);
	W1->insertBefore(Y);
	W2->insertBefore(W1);

	// remove useless instruction
	STI1->eraseFromParent();
	STI2->eraseFromParent();
	// nextGEPI->eraseFromParent();
}

}