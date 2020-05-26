#ifndef HEAP_TO_STACK_H
#define HEAP_TO_STACK_H

#include "llvm/IR/Function.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/PassManager.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/ValueMap.h"
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
class HeapToStackPass : public PassInfoMixin<HeapToStackPass>{
public:
//   This run function is the main function of this class.
  PreservedAnalyses run(Module &M, ModuleAnalysisManager &MAM);

  bool CheckCondition(Function &f, CallInst *malloc);

  AllocaInst* ReplaceWithAlloca(CallInst *malloc, int num);
  // Check If the malloc pointer address is stored to any other variable in the current function.
  // And if the variable is used to call some functions as argument, check the function too by calling this fucntion recursively
  // If this function is called initially, malloc value is call instruction 
  // but if not, it would be an argument in function. So we should know the number of arg.
  bool IsStoredInFunction(Function &f, Instruction *mallocInst, int argNum);

  int GetPointerSize(Type *type)
  {
    auto *ptrType = dyn_cast<PointerType>(type);
    return ptrType->getElementType()->getScalarSizeInBits();
  }

  map<Value *, Function *> functions_done;
};

extern "C" ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return {
    LLVM_PLUGIN_API_VERSION, "HeapToStackPass", "v0.1",
    [](PassBuilder &PB) {
      PB.registerPipelineParsingCallback(
        [](StringRef Name, ModulePassManager &MPM,
           ArrayRef<PassBuilder::PipelineElement>) {
          if (Name == "heap-stack") {
            MPM.addPass(HeapToStackPass());
            return true;
          }
          return false;
        }
      );
    }
  };
}

} // namespace optim

#endif