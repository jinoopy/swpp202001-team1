#ifndef COMBINE_INST_H
#define COMBINE_INST_H

#include "llvm/IR/Function.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/PassManager.h"
#include "llvm/IR/IRBuilder.h"

#include "llvm/Analysis/PostDominators.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"

#include "llvm/Transforms/InstCombine/InstCombine.h"

#include <map>
#include <vector>
using namespace llvm;
using namespace std;

namespace optim {
class CombineInstPass : public PassInfoMixin<CombineInstPass> {
public:
    PreservedAnalyses run(Module &, ModuleAnalysisManager &);

};

extern "C" ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo()
{
    return {
        LLVM_PLUGIN_API_VERSION, "CombineInstPass", "v0.1",
        [](PassBuilder &PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, ModulePassManager &MPM,
                   ArrayRef<PassBuilder::PipelineElement>) {
                    if (Name == "combine-inst")
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