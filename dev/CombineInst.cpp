#include "CombineInst.h"

using namespace llvm;
using namespace std;

namespace optim {

PreservedAnalyses CombineInstPass::run(Module &M, ModuleAnalysisManager &MAM) {
    PassManager<Function, FunctionAnalysisManager> FPM;
    FPM.addPass(InstCombinePass());
    for(Function &F : M) {
        FunctionAnalysisManager FAM;
        FPM.run(F, FAM);
    }

    LLVMContext &llvmContext = M.getContext();
    Type *i32Type = Type::getInt32Ty(llvmContext);

    for(Function &F : M) {
        for (BasicBlock &BB : F) {
            for (Instruction &I : BB) {
                IRBuilder<> Builder(&I);
                Value *res = dyn_cast<Value>(&I);
                Value *lhs = dyn_cast<Value>(I.getOperand(0));
                Value *rhs = dyn_cast<Value>(I.getOperand(1));
                ConstantInt *rhsC = dyn_cast<ConstantInt>(rhs);
                if(I.isShift() && rhsC) {
                    int64_t rhsVal = rhsC->getSExtValue();
                    if(I.getOpcode() == Instruction::Shl) {
                        Builder.CreateMul(lhs, ConstantInt::get(i32Type, 1<<rhsVal, true));
                    } else {
                        Builder.CreateSDiv(lhs, ConstantInt::get(i32Type, 1<<rhsVal, true));
                    }
                    I.eraseFromParent();
                } 
                else if(I.getOpcode() == Instruction::Add && rhsC && rhsC->getSExtValue() == 0) {
                    Builder.CreateMul(lhs, ConstantInt::get(i32Type, 1, true));
                    I.eraseFromParent();
                }
                else if(I.getOpcode() == Instruction::And && res->getType()->isIntegerTy(1)) {
                    Builder.CreateMul(lhs, rhs);
                    I.eraseFromParent();
                }
            }
        }
    }

    return PreservedAnalyses::all();
}

}