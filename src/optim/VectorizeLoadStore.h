#ifndef VECTORIZE_LOAD_STORE_H
#define VECTORIZE_LOAD_STORE_H

#include "llvm/IR/PassManager.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/PatternMatch.h"
#include "llvm/IR/Instructions.h"

#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"

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

extern "C" ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo()
{
    return {
        LLVM_PLUGIN_API_VERSION, "VectorizeLoadStorePass", "v0.1",
        [](PassBuilder &PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, ModulePassManager &MPM,
                   ArrayRef<PassBuilder::PipelineElement>) {
                    if (Name == "vectorize")
                    {
                        MPM.addPass(VectorizeLoadStorePass());
                        return true;
                    }
                    return false;
                });
        }};
}

}

#endif