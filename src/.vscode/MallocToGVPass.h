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

    //getMallocType(): finds the actual pointer type of malloc()
    //tracks the first bitcast operation done by malloc
    //returns i8* for default
    Type* getMallocType(CallInst*);

    //getInitVal(): finds the first store and fetch the value stored.
    //if the store is not constant, returns nullptr
    Constant* getMallocInitVal(CallInst*);

    //replaceMallocToGv():
    //perform AliasAnalysis and find every use of malloc
    //replace every load&store operations which memory alias
    void replaceMallocToGV(CallInst*, GlobalVariable*);

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