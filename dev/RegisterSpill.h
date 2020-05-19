#ifndef REGISTER_ALLOC_H
#define REGISTER_ALLOC_H

#include "llvm/IR/Function.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/PassManager.h"

#include "llvm/Analysis/PostDominators.h"

#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"

#include "llvm/Support/raw_ostream.h"

#include "LivenessAnalysis.h"

#include <map>
#include <vector>
#include <set>
#include <algorithm>

using namespace llvm;
using namespace std;

namespace backend
{

//For stack-loaded variables, cost needed per color is the sum of:
//spilled variables are proven to reside in 
static const float ALLOCA_COST = 1.2,
                   LOAD_COST = 2,
                   STORE_COST = 2;

//static const unsigned int AVAILABLE_REG = 16;
static const unsigned int AVAILABLE_REG = 16;

class SpillCostAnalysis : public AnalysisInfoMixin<SpillCostAnalysis>
{
  friend AnalysisInfoMixin<SpillCostAnalysis>;
  static AnalysisKey Key;

public:

  //For undecided iterations of loops, the default iteration count.
  static const unsigned DEFAULT_LOOP = 50;

  //1-1 mapping between colors(unsigned int) and spill cost(float)
  using Result = map<Function*, vector<float>>;

  //Calculates the estimated spill cost of each set of equally-colored registers.
  //Note that this pass performs just a heuristic method; it may not be accurate
  Result run(Module &M, ModuleAnalysisManager &MAM);

private:

  //Counts the loop trip count considering all layers of loops
  unsigned countLoopTripCount(Instruction*, ScalarEvolution&, LoopInfo&);
  
};

//TODO
class RegisterSpillPass : public PassInfoMixin<RegisterSpillPass>
{
public:
  PreservedAnalyses run(Module &M, ModuleAnalysisManager &MAM);
};

}

#endif