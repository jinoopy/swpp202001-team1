#ifndef VECTORIZE_LOAD_STORE_H
#define VECTORIZE_LOAD_STORE_H

#include "llvm/IR/PassManager.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/PatternMatch.h"
#include "llvm/IR/Instructions.h"

#include <map>
#include <set>
#include <algorithm>
#include <vector>

using namespace llvm;
using namespace std;

namespace optim {

class VectorizeLoadStorePass : public PassInfoMixin<VectorizeLoadStorePass> {
public:
	PreservedAnalyses run(Function &F, FunctionAnalysisManager &AM);
	
private:
	// Vectorizes loads & stores from BB if possible.
	void vectorize(BasicBlock &);

	// helper function for vectorize()
	// finds the induction variable and orders it.
	// indvar: variable which continously increases by 1.
	vector<vector<Instruction *>> findIndvars(BasicBlock &);
	
	// helper function for vectorize()
	// finds all GEP instructions.
	vector<GetElementPtrInst *> findGEPs(BasicBlock &, unsigned);
	void vectorizeLoads(GetElementPtrInst *, GetElementPtrInst *, LoadInst *, LoadInst *, BasicBlock &, unsigned int);
	void vectorizeStores(GetElementPtrInst *, GetElementPtrInst *, StoreInst *, StoreInst *, BasicBlock &, unsigned int);
};

}

#endif