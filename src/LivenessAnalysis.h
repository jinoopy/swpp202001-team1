#include "llvm/IR/PassManager.h"

#include "llvm/IR/Function.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Instruction.h"

#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"

#include "llvm/Support/raw_ostream.h"

#include <map>
#include <vector>

using namespace llvm;
using namespace std;
namespace {

class RegisterGraph {

};

class LivenessAnalysis : PassInfoMixin<LivenessAnalysis>{

vector<Value*>  SearchAllArgInst(Module&);
map<Value*, bool[]> LiveInterval(Module&, vector<Value*>&);
RegisterGraph RegisterClique(Module&, vector<bool[]>&);

public:
  RegisterGraph run(Module &M, ModuleAnalysisManager &MAM);
};
}

extern "C" ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return {
    LLVM_PLUGIN_API_VERSION, "LivenessAnalysis", "v0.1",
    [](PassBuilder &PB) {
      PB.registerPipelineParsingCallback(
        [](StringRef Name, FunctionPassManager &FPM,
           ArrayRef<PassBuilder::PipelineElement>) {
          if (Name == "liveness") {
            FPM.addPass(LivenessAnalysis());
            return true;
          }
          return false;
        }
      );
    }
  };
}