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

//Finds all instructions that can be 'alive' in some point.
//i.e. finds all Arguments & Instructions which refer to 'values'.
//GVs and non-value Inst.(store, br, ...) are not considered.
vector<Value*>  SearchAllArgInst(Module&);

//Recursively(post-order) searches through all instructions
//mark liveness of each values in each instruction
template<int N>
map<Instruction*, vector<bool>> LiveInterval(Module&, vector<Value*>&);

//for all bool[] array, if two values are marked 'true' together,
//there exists a line between two values.
RegisterGraph RegisterClique(Module&, vector<vector<bool>>&);

class LivenessAnalysis : PassInfoMixin<LivenessAnalysis>{

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