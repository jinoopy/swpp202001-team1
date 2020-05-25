/*
    CombineInstPass
    본 pass는 InstCombinePass 직후에 실행되아야 함. (-instcombine)
*/

#include "CombineInst.h"

using namespace llvm;
using namespace std;

namespace optim {

PreservedAnalyses CombineInstPass::run(Module &M, ModuleAnalysisManager &MAM) {
    LLVMContext &llvmContext = M.getContext();
    Type *i32Type = Type::getInt32Ty(llvmContext);

    for(Function &F : M) {
        for(auto it = inst_begin(&F); it!=inst_end(&F); ++it) {
            Instruction& I = *it;
            if(!I.isBinaryOp()) continue;
            IRBuilder<> Builder(&I);
            Value *lhs = I.getOperand(0);
            Value *rhs = I.getOperand(1);
            ConstantInt *rhsC = dyn_cast<ConstantInt>(rhs);
            //shift to mul,div
            if(rhsC && I.isShift()) {
                int64_t rhsVal = rhsC->getSExtValue();
                if(I.getOpcode() == Instruction::Shl) {
                    Builder.CreateMul(lhs, ConstantInt::get(I.getType(), 1<<rhsVal, true));
                } else {
                    Builder.CreateSDiv(lhs, ConstantInt::get(I.getType(), 1<<rhsVal, true));
                }
                I.eraseFromParent();
            } 
            //register move
            else if(rhsC && isMove(I, rhsC->getSExtValue())) { 
                Builder.CreateMul(lhs, ConstantInt::get(I.getType(), 1, true));
                I.eraseFromParent();
            }
            //i1 and to mul
            else if(I.getOpcode() == Instruction::And && I.getType()->isIntegerTy(1)) { 
                Builder.CreateMul(lhs, rhs);
                I.eraseFromParent();
            }
        }
    }

    return PreservedAnalyses::all();
}

bool CombineInstPass::isMove(Instruction &I, int64_t rhsVal) {
    return (I.getOpcode() == Instruction::Add && rhsVal == 0) //x + 0
        || (I.getOpcode() == Instruction::Sub && rhsVal == 0) //x - 0
        || (I.getOpcode() == Instruction::Or && rhsVal == 0) //x | 0
        || (I.getOpcode() == Instruction::And && rhsVal == -1) //x & (-1)
        || (I.getOpcode() == Instruction::Xor && rhsVal == 0) //x ^ 0
        || (I.isShift() && rhsVal == 0); //x << 0, x >> 0
}

}