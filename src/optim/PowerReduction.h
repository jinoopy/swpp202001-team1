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
class CombineInstPass : public PassInfoMixin<CombineInstPass> {
public:
    PreservedAnalyses run(Module &, ModuleAnalysisManager &);

private:
    void replaceShiftWithMulDiv(IRBuilder<>, Instruction &, int64_t);
    bool isRegMove(Instruction &, int64_t);
    void replaceRegMoveWithMul(IRBuilder<>, Instruction &, int64_t);
    void replaceLSBBitMaskWithRem(IRBuilder<>, Instruction &, int64_t);
    void replace1BitAndWithMul(IRBuilder<>, Instruction &);
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
                        MPM.addPass(CombineInstPass());
                        return true;
                    }
                    return false;
                });
        }};
}
}

#endif 