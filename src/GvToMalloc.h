#ifndef LIVENESS_ANALYSIS_H
#define LIVENESS_ANALYSIS_H

#include "llvm/IR/Function.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/PassManager.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Module.h"

#include "llvm/Analysis/PostDominators.h"

#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"

#include "llvm/Support/raw_ostream.h"

#include <map>
#include <vector>
#include <string>

using namespace llvm;
using namespace std;

namespace optim {
class GvToMalloc : public PassInfoMixin<GvToMalloc>{
public:
  Function *RecreateFunction(Function *Func, FunctionType *NewType);
//   Make new malloc variable to replace the GV
  // And make store instruction after the call instruction
//   And the return value(Value*) will be used to add arguments of function 
  Value* MakeNewMalloc(Module &M, LLVMContext &Context, Type *type, llvm::Constant *value, int m_index);

//   When Malloc variable is added, we have to give the variables to other functions.
//   So we should add some arguments in function definition before we put the variables to call instruction of functions.
  void AddArgumentsToFunctionDef(Module &M, LLVMContext &Context, Function &f, Type *gv_type); // This function only needs the size of the malloc variable
  
//   After the definition of function changes, 
//   we should put new malloc variables to call instruction of functions.
  void AddArgumentsToCallInst(Instruction* malloc);

//   This run function is the main function of this class.
  PreservedAnalyses run(Module &M, ModuleAnalysisManager &MAM);
};

}
/*
TODO This causes error
extern "C" ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return {
    LLVM_PLUGIN_API_VERSION, "LivenessAnalysis", "v0.1",
    [](PassBuilder &PB) {
      PB.registerPipelineParsingCallback(
        [](StringRef Name, ModulePassManager &MPM,
           ArrayRef<PassBuilder::PipelineElement>) {
          if (Name == "liveness") {
            MPM.addPass(LivenessAnalysis());
            return true;
          }
          return false;
        }
      );
    }
  };
}
*/

#endif