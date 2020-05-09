#ifndef MALLOC_GV_H
#define MALLOC_GV_H

#include "llvm/IR/PassManager.h"
#include "llvm/IR/GlobalVariable.h"

#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"

#include "llvm/Support/raw_ostream.h"
#include <string>

using namespace llvm;

namespace optim
{
class MallocToGVPass : public PassInfoMixin<MallocToGVPass>
{
public:
    //run() Transforms:
    //All malloc() in the entry block of main() to GV
    //all uses of malloc in main to GV
    PreservedAnalyses run(Module &, ModuleAnalysisManager &);

private:
    Module* M;
    ModuleAnalysisManager* MAM;

    Constant* getInitVal(Instruction* ptr);

    void replaceAllUseToGV(Instruction* malloc, GlobalVariable* gv);

};

extern "C" ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo()
{
    return {
        LLVM_PLUGIN_API_VERSION, "MallocToGVPass", "v0.1",
        [](PassBuilder &PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, ModulePassManager &MPM,
                   ArrayRef<PassBuilder::PipelineElement>) {
                    if (Name == "malloc-gv")
                    {
                        MPM.addPass(MallocToGVPass());
                        return true;
                    }
                    return false;
                });
        }};
}

} // namespace optim

#endif