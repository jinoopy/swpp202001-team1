/*
    GEPUnpackPass
*/

#include "GEPUnpack.h"

using namespace llvm;
using namespace std;

namespace optim {

PreservedAnalyses GEPUnpackPass::run(Module &M, ModuleAnalysisManager &MAM) {
    LLVMContext &Context = M.getContext();
    for(Function &F : M) {
		set<Instruction *> s;
        for(auto it = inst_begin(&F); it!=inst_end(&F); ++it) {
            Instruction &I = *it;
            if(I.getOpcode() != Instruction::GetElementPtr) continue;

            IRBuilder<> Builder(&I);
            GetElementPtrInst *GI = dyn_cast<GetElementPtrInst>(&I);

            Value* ptrOp = GI->getPointerOperand();
            Type* curr = ptrOp->getType();
            curr = curr->getPointerElementType();

            Value* pti = Builder.CreatePtrToInt(ptrOp, IntegerType::getInt64Ty(Context));
            
            Value* sum = pti;
            for(auto opIt = GI->idx_begin(); opIt!=GI->idx_end(); ++opIt) {
                Value *op = *opIt;
                unsigned int size = getAccessSize(curr);
                Value* mul = Builder.CreateMul(op, ConstantInt::get(IntegerType::getInt64Ty(Context), size, true));
                sum = Builder.CreateAdd(sum, mul);
                if(curr->isArrayTy()) curr = curr->getArrayElementType();
            }

            Value* itp = Builder.CreateIntToPtr(sum, I.getType());
            I.replaceAllUsesWith(itp);
			s.insert(&I);
        }
		for(auto &I : s) {
			I->eraseFromParent();
		}
    }

    return PreservedAnalyses::all();
}
}