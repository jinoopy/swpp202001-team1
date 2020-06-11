/*
    CombineInstPass
    본 pass는 InstCombinePass 직전과 직후에 실행되어야 함.
    Prerequirement: -gvn
    (ex. -gvn -combineinst -instcombine -combineinst )
*/

#include "PowerReduction.h"

using namespace llvm;
using namespace std;

namespace optim {

PreservedAnalyses CombineInstPass::run(Module &M, ModuleAnalysisManager &MAM) {
    for(Function &F : M) {
        for(auto it = inst_begin(&F); it!=inst_end(&F); ++it) {
            Instruction& I = *it;
            if(!I.isBinaryOp()) continue;

            IRBuilder<> Builder(&I);
            ConstantInt *rhsC = dyn_cast<ConstantInt>(I.getOperand(1));

            if(rhsC) {
                int64_t rhsVal = rhsC->getSExtValue();
                replaceShiftWithMulDiv(Builder, I, rhsVal);
                replaceRegMoveWithMul(Builder, I, rhsVal);
                replaceLSBBitMaskWithRem(Builder, I, rhsVal);
            }
            replace1BitAndWithMul(Builder, I);
        }
    }

    return PreservedAnalyses::all();
}

void CombineInstPass::replaceShiftWithMulDiv(IRBuilder<> Builder, Instruction &I, int64_t rhsVal) {
    if(I.isShift()) {
        if(I.getOpcode() == Instruction::Shl) {
            Builder.CreateMul(I.getOperand(0), ConstantInt::get(I.getType(), 1<<rhsVal, true));
        } else {
            Builder.CreateSDiv(I.getOperand(0), ConstantInt::get(I.getType(), 1<<rhsVal, true));
        }
        I.eraseFromParent();
    }
}

bool CombineInstPass::isRegMove(Instruction &I, int64_t rhsVal) {
    return (I.getOpcode() == Instruction::Add && rhsVal == 0) //x + 0
        || (I.getOpcode() == Instruction::Sub && rhsVal == 0) //x - 0
        || (I.getOpcode() == Instruction::Or && rhsVal == 0) //x | 0
        || (I.getOpcode() == Instruction::And && rhsVal == -1) //x & (-1)
        || (I.getOpcode() == Instruction::Xor && rhsVal == 0) //x ^ 0
        || (I.isShift() && rhsVal == 0); //x << 0, x >> 0
}

void CombineInstPass::replaceRegMoveWithMul(IRBuilder<> Builder, Instruction &I, int64_t rhsVal) {
    if(isRegMove(I, rhsVal)) {
        Builder.CreateMul(I.getOperand(0), ConstantInt::get(I.getType(), 1, true));
        I.eraseFromParent();
    }
}

void CombineInstPass::replace1BitAndWithMul(IRBuilder<> Builder, Instruction &I) {
    if(I.getOpcode() == Instruction::And && I.getType()->isIntegerTy(1)) {
        Builder.CreateMul(I.getOperand(0), I.getOperand(1));
        I.eraseFromParent();
    }
}

void CombineInstPass::replaceLSBBitMaskWithRem(IRBuilder<> Builder, Instruction &I, int64_t rhsVal) {
    if(I.getOpcode() == Instruction::And && (rhsVal & (rhsVal+1)) == 0) { 
        Builder.CreateSRem(I.getOperand(0),  ConstantInt::get(I.getType(), rhsVal+1, true));
        I.eraseFromParent();
    }
} //(rhsVal == -1)인 경우는 replaceRegMoveWithMul에서 처리됨.

}