#ifndef STACK_HEAP_ACCESS_GROUP_H
#define STACK_HEAP_ACCESS_GROUP_H

#include "llvm/IR/PassManager.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/PatternMatch.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"

#include <map>
#include <set>
#include <algorithm>
#include <vector>
#include <queue>

#include <iostream>

using namespace llvm;
using namespace std;

namespace optim {

enum AllocType {
	STACK, HEAP, UNKNOWN
};

AllocType getBlockType(const Value *V);

class StackHeapAccessGroupPass : public PassInfoMixin<StackHeapAccessGroupPass> {
public:
	PreservedAnalyses run(Function &F, FunctionAnalysisManager &FAM);

private:
	int getTopologicalSort(map<Instruction *, vector<Instruction *>> &adjacentList, map<Instruction *, int> indegree, 
							set<Instruction *> &heapAccess, set<Instruction *> &stackAccess, AllocType firstType,
							vector<Instruction *> &result, map<Instruction *, int> &indexOfInst);

};

extern "C" ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
	return {
		LLVM_PLUGIN_API_VERSION, "StackHeapAccessGroupPass", "v0.1",
		[](PassBuilder &PB) {
			PB.registerPipelineParsingCallback (
				[](StringRef Name, ModulePassManager &MPM,
				ArrayRef<PassBuilder::PipelineElement>) {
					if (Name == "group-access") {
						FunctionPassManager FPM;
						FPM.addPass(StackHeapAccessGroupPass());
						MPM.addPass(createModuleToFunctionPassAdaptor(std::move(FPM)));
						return true;
					}
					return false;
				}
			);
		}
	};
}

}

#endif