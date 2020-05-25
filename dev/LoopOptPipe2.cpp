#include "LoopOptPipe2.h"

#define DEBUG() puts("TRY DEBUG")

using namespace llvm;
using namespace std;

/*
namespace {
	struct LoopOptPipe2Class : public FunctionPass {
    	static char ID; // Pass identification, replacement for typeid
    	LoopOptPipe2Class() : FunctionPass(ID) {
    		initializeLoopOptPipe2ClassPass(*PassRegistry::getPassRegistry());
		}
 
    	bool runOnFunction(Function &F) override {

		}
 
     	void getAnalysisUsage(AnalysisUsage &AU) const override {
			AU.addRequired<AssumptionCacheTracker>();
		
			// We need loop information to identify the loops...
			AU.addRequired<DominatorTreeWrapperPass>();
			AU.addPreserved<DominatorTreeWrapperPass>();
		
			AU.addRequired<LoopInfoWrapperPass>();
			AU.addPreserved<LoopInfoWrapperPass>();
		
			AU.addPreserved<BasicAAWrapperPass>();
			AU.addPreserved<AAResultsWrapperPass>();
			AU.addPreserved<GlobalsAAWrapperPass>();
			AU.addPreserved<ScalarEvolutionWrapperPass>();
			AU.addPreserved<SCEVAAWrapperPass>();
			AU.addPreservedID(LCSSAID);
			AU.addPreserved<DependenceAnalysisWrapperPass>();
			AU.addPreservedID(BreakCriticalEdgesID);  // No critical edges added.
			AU.addPreserved<BranchProbabilityInfoWrapperPass>();
			if (EnableMSSALoopDependency)
				AU.addPreserved<MemorySSAWrapperPass>();
		}
 
     	/// verifyAnalysis() - Verify LoopSimplifyForm's guarantees.
     	void verifyAnalysis() const override;
   	};
}
*/

PreservedAnalyses optim::LoopOptPipe2::run(Module &M, ModuleAnalysisManager &MAM) {

	/*
	PassManager<Function, FunctionAnalysisManager> FPM;
    FPM.addPass(LoopSimplify());

    // PassManager<Loop, LoopAnalysisManager> LPM;
	Pass *P = createLCSSAPass();

	PassManagerBuilder PMB = PassManagerBuilder();

	INITIALIZE_PASS_BEGIN

	PMStack PMS;
	LPPassManager *temp = new LPPassManager();
	DEBUG();
	temp->add(P);
	DEBUG();
	PMS.push(temp);
	// P->assignPassManager(PMS, PMT_LoopPassManager);
	DEBUG();
	
	for(Function &F : M) {
		LPPassManager *LPPM = (LPPassManager *)(PMS.top());
		LPPM->runOnFunction(F);
		DEBUG();
	}
    LPM.addPass(*createLCSSAPass());
    LPM.addPass(*createLICMPass());
    LPM.addPass(*createLoopRotatePass(10));
    LPM.addPass(*createLoopUnswitchPass(OS, hasBranchDivergence));
	*/

    for(Function &F : M) {
        FunctionAnalysisManager FAM;

		LoopSimplifyPass LSP = LoopSimplifyPass();
		LSP.run(F, FAM);
	}
		/*
		RegisterPass<PassInfo> RP = RegisterPass<PassInfo>();
		
		cout << LSP.name().str() << endl;
		LSP.run(F, FAM);

		LCSSAPass LP;
		LP.run(F, FAM);

		
        FPM.run(F, FAM);
        LoopInfo &LI = getAnalysis<LoopInfoWrapperPass>().getLoopInfo();
        for(Loop &L : LI) {
            LoopAnalysisManager LAM;
            LPM.run(L, LAM);
        }
		*/
	
    return PreservedAnalyses::all();
}