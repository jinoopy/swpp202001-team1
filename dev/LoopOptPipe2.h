#ifndef LOOP_OPT_PIPE2_H
#define LOOP_OPT_PIPE2_H

#include "llvm/IR/Function.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/PassManager.h"
#include "llvm/Analysis/PostDominators.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"

#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Transforms/Scalar/LoopPassManager.h"
#include "llvm/Transforms/Scalar/LoopSimplifyCFG.h"
#include "llvm/Transforms/Scalar/LICM.h"
#include "llvm/Transforms/Utils/LCSSA.h"
#include "llvm/Transforms/Utils/LoopSimplify.h"
#include "llvm/Transforms/Utils.h"

#include "llvm/Analysis/LoopPass.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"

#include <iostream>

using namespace llvm;
using namespace std;

namespace optim {

class LoopOptPipe2 : public PassInfoMixin<LoopOptPipe2> {
public:
	PreservedAnalyses run(Module &M, ModuleAnalysisManager &MAM);
private:

};

extern "C" ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
    return {
        LLVM_PLUGIN_API_VERSION, "LoopOptPipe2", "v0.1",
        [](PassBuilder &PB) {
            PB.registerPipelineParsingCallback (
                [](StringRef Name, ModulePassManager &MPM,
                   ArrayRef<PassBuilder::PipelineElement>) {
                    if (Name == "loop-opt-pipe2") {
                        MPM.addPass(LoopOptPipe2());
                        return true;
                    }
                    return false;
                });
        }};
}

}

#endif