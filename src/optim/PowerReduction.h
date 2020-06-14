#ifndef POWER_REDUC_H
#define POWER_REDUC_H

#include "llvm/IR/Function.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/PassManager.h"
#include "llvm/IR/IRBuilder.h"

#include "llvm/Analysis/PostDominators.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"

#include <map>
#include <vector>
using namespace llvm;
using namespace std;

namespace optim {
class PowerReductionPass : public PassInfoMixin<PowerReductionPass> {
public:
    PreservedAnalyses run(Module &, ModuleAnalysisManager &);

private:
    BasicBlock::iterator replaceShiftWithMulDiv(BasicBlock::iterator, uint64_t);
    bool isRegMove(Instruction &, uint64_t);
    BasicBlock::iterator replaceRegMoveWithMul(BasicBlock::iterator, uint64_t);
    BasicBlock::iterator replaceLSBBitMaskWithRem(BasicBlock::iterator, uint64_t);
    BasicBlock::iterator replace1BitAndWithMul(BasicBlock::iterator);
};

extern "C" ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo()
{
    return {
        LLVM_PLUGIN_API_VERSION, "PowerReductionPass", "v0.1",
        [](PassBuilder &PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, ModulePassManager &MPM,
                   ArrayRef<PassBuilder::PipelineElement>) {
                    if (Name == "power-reduc")
                    {
                        MPM.addPass(PowerReductionPass());
                        return true;
                    }
                    return false;
                });
        }};
}
}

#endif 