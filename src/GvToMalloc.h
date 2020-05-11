#ifndef LIVENESS_ANALYSIS_H
#define LIVENESS_ANALYSIS_H

#include "llvm/IR/Function.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/PassManager.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Module.h"
#include "llvm/Transforms/Utils/Cloning.h"

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
//   This run function is the main function of this class.
  PreservedAnalyses run(Module &M, ModuleAnalysisManager &MAM);

//   Make new malloc variable to replace the GV
  // And make store instruction after the call instruction
//   And the return value(Value*) will be used to add arguments of function 
  Value* MakeNewMalloc(Module &M, LLVMContext &Context, Type *type, llvm::Constant *value, int m_index);

//   When Malloc variable is added, we have to give the variables to other functions.
//   So we should add some arguments in function definition before we put the variables to call instruction of functions.
//   To do this, we first get all the malloc variables And add them as new arguments in function.
  Function& AddArgumentsToFunctionDef(Module &M, LLVMContext &Context, Function &f, vector<Value *> malloc);
  
//   After the  change of function definition, 
//   we should put new malloc variables to call instructions of functions.
//   In case of main function, we will use the malloc variables as the arguments of call instructions.
//   And case of other functions, we will use the function arguments as the arguments of call instructions. 
  void AddArgumentsToCallInst(map<Function *, Function *> fMap, Function &f, vector<Value *> malloc);
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