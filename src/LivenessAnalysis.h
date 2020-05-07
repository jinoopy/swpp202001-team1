#ifndef LIVENESS_ANALYSIS_H
#define LIVENESS_ANALYSIS_H

#include "llvm/IR/Function.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/PassManager.h"

#include "llvm/Analysis/PostDominators.h"

#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"

#include "llvm/Support/raw_ostream.h"

#include <map>
#include <vector>

using namespace llvm;
using namespace std;

namespace backend {

//RegisterGraph: stores the colored register graph information
class RegisterGraph {
public:
  //TODO
  //Should move into Constructor local variable
  vector<vector<bool>> live_values;

  //Construct RegisterGraph with Module
  RegisterGraph(Module&);

  //Finds all instructions that can be alive in some point.
  //i.e. finds all Arguments & Instructions that contain valid values.
  //GVs and non-value Inst.(store, br, ...) are not considered.
  vector<Value*>  SearchAllArgInst(Module&);

  //Recursively(post-order) searches through all instructions
  //mark liveness of each values in each instruction
  vector<vector<bool>> LiveInterval(Module&, vector<Value*>&);

  //helper function for LiveInterval(); does the recursive search
  bool LivenessSearch(Instruction&, Value&, int, map<Instruction*, vector<bool>>&, DominatorTree&);

};

class LivenessAnalysis : public AnalysisInfoMixin<LivenessAnalysis>{
  friend AnalysisInfoMixin<LivenessAnalysis>;
  static AnalysisKey Key;
public:
  using Result = RegisterGraph;
  RegisterGraph run(Module &M, ModuleAnalysisManager &MAM);
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