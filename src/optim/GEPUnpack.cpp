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
        for(auto it = inst_begin(&F); it!=inst_end(&F); ++it) {
            Instruction &I = *it;
            if(I.getOpcode() != Instruction::GetElementPtr) continue;

            IRBuilder<> Builder(&I);
            GetElementPtrInst *GI = dyn_cast<GetElementPtrInst>(&I);

            Value* ptrOp = GI->getPointerOperand();
            Type* curr = dyn_cast<Type>(ptrOp);

            uint64_t offset = 0;
            for(auto opIt = GI->idx_begin(); opIt!=GI->idx_end(); ++opIt) {
                Value *op = *opIt;
                unsigned int opSize = getAccessSize(curr);
                int64_t opVal = dyn_cast<ConstantInt>(op)->getSExtValue();
                offset += opVal * opSize;
                if(curr->isArrayTy()) curr = curr->getArrayElementType();
            }
            
            Value* pti = Builder.CreatePtrToInt(ptrOp, IntegerType::getInt64Ty(Context));
            Value* add = Builder.CreateAdd(pti, ConstantInt::get(IntegerType::getInt64Ty(Context), offset, true));
            Value* itp = Builder.CreateIntToPtr(add, ptrOp->getType());
            I.eraseFromParent();
        }
    }

    return PreservedAnalyses::all();
}
}