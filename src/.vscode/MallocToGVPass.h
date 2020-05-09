#ifndef MALLOC_GV_H
#define MALLOC_GV_H

#include "llvm/IR/PassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"
#include<string>
using namespace llvm;

namespace {
class MallocToGVPass : public PassInfoMixin<MallocToGVPass> {
public:
  PreservedAnalyses run(Module &, ModuleAnalysisManager &);
};
}

extern "C" ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return {
    LLVM_PLUGIN_API_VERSION, "MallocToGVPass", "v0.1",
    [](PassBuilder &PB) {
      PB.registerPipelineParsingCallback(
        [](StringRef Name, ModulePassManager &MPM,
           ArrayRef<PassBuilder::PipelineElement>) {
          if (Name == "malloc-gv") {
            MPM.addPass(MallocToGVPass());
            return true;
          }
          return false;
        }
      );
    }
  };
}

#endif