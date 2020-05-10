#ifndef LOOP_OPTIM_PIPE1_H
#define LOOP_OPTIM_PIPE1_H

#include "llvm/IR/Function.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/PassManager.h"
#include "llvm/Analysis/PostDominators.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"

#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Transforms/Scalar/LoopPassManager.h"
#include "llvm/Transforms/Scalar/LoopSimplifyCFG.h"
#include "llvm/Transforms/Scalar/LICM.h"



#include <map>
#include <vector>
using namespace llvm;
using namespace std;

namespace optim {
class LoopOptimPipe1 : public AnalysisInfoMixin<LoopOptimPipe1> {
private:
    friend AnalysisInfoMixin<LoopOptimPipe1>;
    static AnalysisKey Key;
public:
    PreservedAnalyses run(Module &M, ModuleAnalysisManager &MAM);
};
}

#endif 