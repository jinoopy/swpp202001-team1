#ifndef MALLOC_GV_H
#define MALLOC_GV_H

#include "llvm/IR/PassManager.h"
#include "llvm/IR/GlobalVariable.h"

#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"

#include "llvm/Support/raw_ostream.h"
#include <set>
#include <queue>

using namespace llvm;
using namespace std;

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
    //Module scope of analysis
    Module* M;
    //Context of M
    LLVMContext* Context;
    //Module Analysis Manager
    ModuleAnalysisManager* MAM;
    //main() from the Module M
    Function* FMain;

    //getMallocType(): finds the actual pointer type of malloc()
    //tracks the first bitcast operation and returns it, nullptr if not found
    BitCastInst* getMallocType(CallInst* malloc);

    //getInitVal(): finds the first store returns it
    //traks the first store operation and returns it, nullptr if not found
    //store should be constant to be globalized
    StoreInst* getMallocInitVal(Instruction* malloc);

    //replaceMallocToGv():
    //perform AliasAnalysis and find every use of CallInst
    //replace every operations which share value
    void replaceMallocToGV(Instruction* malloc, GlobalVariable*);

    //helper function for replaceMallocToGV()
    //finds argument-propagated replicants of the Value* argument
    map<Function*, Value*> findEqualPtrArgs(Value* malloc);

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