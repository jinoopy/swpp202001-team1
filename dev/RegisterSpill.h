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

class RegisterSpillPass : public PassInfoMixin<RegisterSpillPass>
{
  //Module which this analysis runs.
  Module* M;
  //Register graph for the module.
  RegisterGraph RG;

public:

  //Register file size of the target machine.
  //static const unsigned REGISTER_CAP = 16;
  //FIXME: Testing purposes(Most conventional level programs fall in 16 regs)
  static const unsigned REGISTER_CAP = 4;

  //Finds the registers that need to be spilled
  //and actually spills them by adding alloca, store, and load.
  PreservedAnalyses run(Module &M, ModuleAnalysisManager &MAM);

private:

  //Searches through all functions and check if the spilling is enough.
  bool spilledEnough(unsigned, vector<bool>, Function*, RegisterGraph&);

  //Pre-order traverses through the function's basic blocks.
  //In this way, if a BB has a single predecessor, the register state is already calculated.
  //Spills the registers by adding store and load instructions.
  void spillRegister(const vector<bool>&, const vector<AllocaInst*>&, map<BasicBlock*, vector<bool>>&, BasicBlock&);
};

}

#endif