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
#include <set>
#include <algorithm>

using namespace llvm;
using namespace std;

namespace backend
{

//RegisterGraph: stores the colored register graph information and provides interface
class RegisterGraph
{

public:

  //Constructors

  RegisterGraph(Module &);

  //Interfaces

  auto& getValues() {return values;}

  auto& getAdjList() {return adjList;}
  auto& getAdjList(Value* v) {return adjList[v];}

  int getNumColors() {return NUM_COLORS;}

  auto& getValueToColor() {return valueToColor;}
  unsigned int getValueToColor(Value* v) {return valueToColor[v];}

  auto& getColorToValue() {return colorToValue;}

private:
  
  //Private Variables

  //values: result of SearchAllArgInst()
  vector<Value *> values;

  //adjList: result of LiveInterval() + RegisterAdjList()
  map<Value *, set<Value *>> adjList;

  //NUM_COLORS, valueToColor: result of ColorGraph();
  //NUM_COLORS: total colors used ( 0 < c < NUM_COLORS)
  //valueToColor: Value=>color mapping
  unsigned int NUM_COLORS;
  map<Value *, unsigned int> valueToColor;

  //colorToValue: result of InverseColorMap()
  //color->Value mapping
  vector<vector<Value *>> colorToValue;

  //Functions for constructor RegisterGraph(Module&)

  //1. Construct liveness interval

  //Finds all instructions that can be alive in some point.
  //i.e. finds all Arguments & Instructions that contain valid values.
  //GVs and non-value Inst.(store, br, ...) are not considered.
  void SearchAllArgInst(Module &);

  //Recursively(post-order) searches through all instructions
  //mark liveness of each values in each instruction
  vector<vector<bool>> LiveInterval(Module &);
  //helper function for LiveInterval()
  //does the recursive search for dominators and branches
  bool LivenessSearch(Instruction &, Value &, int, map<Instruction *, vector<bool>> &, DominatorTree &);

  //2. Construct live graph and assign different colors to
  //   values which are live together

  //Adjacency list of Argumetns & value-containing Instructions
  //two insts. are adjacent iff live inerval overlap.
  void RegisterAdjList(vector<vector<bool>> &);

  //Colors values so adjacent value have no same color
  //initializes NUM_COLORS, valueToColor
  //TODO add must(function call)&can(phi nodes) coalesce features
  void ColorGraph();
  //helper function for ColorGraph()
  //finds PEO via Lexicographic BFS algorithm
  vector<Value *> PerfectEliminationOrdering();
  //helper function for ColorGraph()
  //colors the graph greedily(adjList always represents a chordal graph)
  void GreedyColoring(vector<Value *> &);

  //Makes colorToValue so easily retrieve all values with same color
  void InverseColorMap();
};

class LivenessAnalysis : public AnalysisInfoMixin<LivenessAnalysis>
{
  friend AnalysisInfoMixin<LivenessAnalysis>;
  static AnalysisKey Key;

public:
  using Result = RegisterGraph;
  RegisterGraph run(Module &M, ModuleAnalysisManager &MAM);
};

} // namespace backend
/* FIXME This causes error
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