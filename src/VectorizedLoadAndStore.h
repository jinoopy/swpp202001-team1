#ifndef VECTORIZED_LOAD_AND_STORE_H
#define VECTORIZED_LOAD_AND_STORE_H

#include "llvm/IR/PassManager.h"

using namespace llvm;

namespace optim {

class VectorizedLoadAndStorePass : public PassInfoMixin<VectorizedLoadAndStorePass> {
public:
	PreservedAnalyses run(Function &F, FunctionAnalysisManager &AM);
private:
	//Vectorizes loads & stores from BB if possible.
	void vectorize(BasicBlock &);

	//helper function for vectorize()
	//finds the induction variable and orders it.
	//indvar: variable which continously increases by 1.
	vector<vector<Instruction *>> findIndvars(BasicBlock &);
	
	//helper function for vectorize()
	//finds all GEP instructions.
	vector<GetElementPtrInst *> findGEPs(BasicBlock &, unsigned);
	void vectorizeLoads(GetElementPtrInst *, LoadInst *, LoadInst *, BasicBlock &, unsigned int);
	void vectorizeStores(GetElementPtrInst *, StoreInst *, StoreInst *, BasicBlock &, unsigned int);
};

}

#endif