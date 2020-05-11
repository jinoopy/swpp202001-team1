#ifndef VECTORIZED_LOAD_AND_STORE_H
#define VECTORIZED_LOAD_AND_STORE_H

#include "llvm/IR/PassManager.h"

using namespace llvm;

namespace optim {

//RegisterGraph: stores the colored register graph information
class VectorizedLoadAndStorePass : public PassInfoMixin<VectorizedLoadAndStorePass> {
public:
	PreservedAnalyses run(Function &F, FunctionAnalysisManager &AM);
};

}

#endif