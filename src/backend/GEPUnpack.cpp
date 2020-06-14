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

            IRBuilder Builder(&I);
            GetElementPtrInst *GI = dyn_cast<GetElementPtrInst>(&I);

            Value* ptrOp = GI->getPointerOperand();
            Type* curr = ptrOp->getType();
            curr = curr->getPointerElementType();

            Instruction *pti = CastInst::CreateBitOrPointerCast(ptrOp, IntegerType::getInt64Ty(Context));
			Builder.Insert(pti);
            
			vector<Instruction *> v;
			v.push_back(pti);
            for(auto opIt = GI->idx_begin(); opIt!=GI->idx_end(); ++opIt) {
                Value *op = *opIt;
                unsigned int size = getAccessSize(curr);
                Instruction *mul = BinaryOperator::CreateMul(op, ConstantInt::get(IntegerType::getInt64Ty(Context), size, true));
				Builder.Insert(mul);
                Instruction *sum = BinaryOperator::CreateAdd(v.back(), mul);
				Builder.Insert(sum);
				v.push_back(sum);
                if(curr->isArrayTy()) curr = curr->getArrayElementType();
            }

            Instruction *itp = CastInst::CreateBitOrPointerCast(v.back(), I.getType());
			Builder.Insert(itp);
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