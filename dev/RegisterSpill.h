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

class SpillCostAnalysis : public AnalysisInfoMixin<SpillCostAnalysis>
{
  friend AnalysisInfoMixin<SpillCostAnalysis>;
  static AnalysisKey Key;

public:

  //For stack-loaded variables, cost needed per color is the sum of:
  static const float ALLOCA_COST = 1.2;
  static const float LOAD_COST = 2;
  static const float STORE_COST = 2;

  //1-1 mapping between colors(unsigned int) and spill cost(float)
  using Result = vector<float>;

  vector<float> run(Module &M, ModuleAnalysisManager &MAM);
};

//TODO
class RegisterSpillPass : public PassInfoMixin<RegisterSpillPass>
{
public:

  //static const unsigned int AVAILABLE_REG = 16;
  static const unsigned int AVAILABLE_REG = 16;
  PreservedAnalyses run(Module &M, ModuleAnalysisManager &MAM);
};

}

#endif