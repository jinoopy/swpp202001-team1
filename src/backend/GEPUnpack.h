#ifndef GEP_UNPACK_H
#define GEP_UNPACK_H

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

namespace backend {
class GEPUnpackPass : public PassInfoMixin<GEPUnpackPass> {
public:
    PreservedAnalyses run(Module &, ModuleAnalysisManager &);

private:

};

extern "C" ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo()
{
    return {
        LLVM_PLUGIN_API_VERSION, "GEPUnpackPass", "v0.1",
        [](PassBuilder &PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, ModulePassManager &MPM,
                   ArrayRef<PassBuilder::PipelineElement>) {
                    if (Name == "gep-unpack")
                    {
                        MPM.addPass(GEPUnpackPass());
                        return true;
                    }
                    return false;
                });
        }};
}
}

#endif 