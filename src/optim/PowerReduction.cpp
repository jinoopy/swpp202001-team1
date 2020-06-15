/*
    PowerReductionPass
    본 pass는 InstCombinePass 직전과 직후에 실행되어야 함.
    Prerequirement: -gvn
    (ex. -gvn -power-reduc -instcombine -power-reduc )
*/

#include "PowerReduction.h"

using namespace llvm;
using namespace std;

namespace optim {

PreservedAnalyses PowerReductionPass::run(Module &M, ModuleAnalysisManager &MAM) {
    for(Function &F : M) {
        if(F.isDeclaration()) continue;
        for(BasicBlock& BB : F) {
            for(auto it = BB.begin(); it!=BB.end();) {
                Instruction& I = *it;

                if(!I.isBinaryOp()){
                   ++it; 
                   continue;
                } 

                ConstantInt *rhsC = dyn_cast<ConstantInt>(I.getOperand(1));

                auto it_prev = it;
                if(rhsC) {
                    int64_t rhsVal = rhsC->getSExtValue();

                    it = replaceShiftWithMulDiv(it, rhsVal);
                    if(it_prev != it) continue;

                    it = replaceRegMoveWithMul(it, rhsVal);
                    if(it_prev != it) continue;

                    it = replaceLSBBitMaskWithRem(it, rhsVal);
                    if(it_prev != it) continue;
                }

                it = replace1BitAndWithMul(it);
                if(it_prev != it) continue;

                ++it;
            }
        }
    }

    return PreservedAnalyses::all();
}

BasicBlock::iterator PowerReductionPass::replaceShiftWithMulDiv(BasicBlock::iterator it, int64_t rhsVal) {
    Instruction& I = *it;
    if(I.isShift()) {
        Value* newI;
        if(I.getOpcode() == Instruction::Shl) {
            newI = BinaryOperator::Create(Instruction::Mul, I.getOperand(0), ConstantInt::get(I.getType(), 1llu<<rhsVal, true), I.getName(), &I);
        } else if(I.getOpcode() == Instruction::AShr) {
            newI = BinaryOperator::Create(Instruction::SDiv, I.getOperand(0), ConstantInt::get(I.getType(), 1llu<<rhsVal, true), I.getName(), &I);
        } else if(I.getOpcode() == Instruction::LShr) {
            newI = BinaryOperator::Create(Instruction::UDiv, I.getOperand(0), ConstantInt::get(I.getType(), 1llu<<rhsVal, true), I.getName(), &I);
        }
        I.replaceAllUsesWith(newI);
        return I.eraseFromParent();
    }
    return it;
}

bool PowerReductionPass::isRegMove(Instruction &I, int64_t rhsVal) {
    return (I.getOpcode() == Instruction::Add && rhsVal == 0) //x + 0
        || (I.getOpcode() == Instruction::Sub && rhsVal == 0) //x - 0
        || (I.getOpcode() == Instruction::Or && rhsVal == 0) //x | 0
        || (I.getOpcode() == Instruction::And && rhsVal == -1) //x & (-1)
        || (I.getOpcode() == Instruction::Xor && rhsVal == 0) //x ^ 0
        || (I.isShift() && rhsVal == 0); //x << 0, x >> 0
}

BasicBlock::iterator PowerReductionPass::replaceRegMoveWithMul(BasicBlock::iterator it, int64_t rhsVal) {
    Instruction& I = *it;
    if(isRegMove(I, rhsVal)) {
        Value* newI;
        newI = BinaryOperator::Create(Instruction::Mul, I.getOperand(0), ConstantInt::get(I.getType(), 1, true), I.getName(), &I);
        I.replaceAllUsesWith(newI);
        return I.eraseFromParent();
    }
    return it;
}

BasicBlock::iterator PowerReductionPass::replace1BitAndWithMul(BasicBlock::iterator it) {
    Instruction& I = *it;
    if(I.getOpcode() == Instruction::And && I.getType()->isIntegerTy(1)) {
        Value* newI;
        newI = BinaryOperator::Create(Instruction::Mul, I.getOperand(0), I.getOperand(1), I.getName(), &I);
        I.replaceAllUsesWith(newI);
        return I.eraseFromParent();
    }
    return it;
}

BasicBlock::iterator PowerReductionPass::replaceLSBBitMaskWithRem(BasicBlock::iterator it, int64_t rhsVal) {
    Instruction& I = *it;
    if(I.getOpcode() == Instruction::And && (rhsVal & (rhsVal+1)) == 0) {
        Value* newI;
        newI = BinaryOperator::Create(Instruction::URem, I.getOperand(0),  ConstantInt::get(I.getType(), rhsVal+1, true), I.getName(), &I);
        I.replaceAllUsesWith(newI);
        return I.eraseFromParent();
    }
    return it;
} //(rhsVal == -1)인 경우는 replaceRegMoveWithMul에서 처리됨.

}