#ifndef CONSTEXPR_REM_H
#define CONSTEXPR_REM_H

#include "llvm/IR/Function.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/PassManager.h"
#include "llvm/IR/IRBuilder.h"

#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;
using namespace std;

namespace backend {
class AddressArgCastPass : public PassInfoMixin<AddressArgCastPass> {
public:
    PreservedAnalyses run(Module &, ModuleAnalysisManager &);
};

extern "C" ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo()
{
    return {
        LLVM_PLUGIN_API_VERSION, "AddressArgCastPass", "v0.1",
        [](PassBuilder &PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, ModulePassManager &MPM,
                   ArrayRef<PassBuilder::PipelineElement>) {
                    if (Name == "addrcast")
                    {
                        MPM.addPass(AddressArgCastPass());
                        return true;
                    }
                    return false;
                });
        }};
}
}

#endif 