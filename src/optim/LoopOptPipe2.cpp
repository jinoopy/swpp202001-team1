#include "LoopOptPipe2.h"

using namespace llvm;
using namespace std;

namespace optim {

PreservedAnalyses LoopOptPipe2::run(Module &M, ModuleAnalysisManager &MAM) {
	LoopAnalysisManager LAM;
	FunctionAnalysisManager FAM;
	CGSCCAnalysisManager CGAM;
	PassBuilder PB;

	PB.registerModuleAnalyses(MAM);
	PB.registerCGSCCAnalyses(CGAM);
	PB.registerFunctionAnalyses(FAM);
	PB.registerLoopAnalyses(LAM);
	PB.crossRegisterProxies(LAM, FAM, CGAM, MAM);

	
	LoopPassManager LPM1, LPM2;
	LPM1.addPass(LoopSimplifyCFGPass());
	// LPM.addPass(LoopInfoWrapperPass());
	// LoopInfoWrapperPass()
	LPM2.addPass(LoopRotatePass());

	FunctionPassManager FPM;
	FPM.addPass(PromotePass());
	FPM.addPass(createFunctionToLoopPassAdaptor(std::move(LPM1)));
	// FPM.addPass(LoopSimplifyCFGPass());
	// FPM.addPass(LICMPass());
	// FPM.addPass(LoopInfoWrapperPass());
	FPM.addPass(LCSSAPass());
	FPM.addPass(LoopSimplifyPass());
	FPM.addPass(createFunctionToLoopPassAdaptor(std::move(LPM2)));
	LoopUnrollOptions LUO = LoopUnrollOptions();
	LUO.setPartial(1);
	LUO.setRuntime(1);
	LUO.setFullUnrollMaxCount(8);
	
	FPM.addPass(LoopUnrollPass(LUO));

	ModulePassManager MPM;

	MPM.addPass(createModuleToFunctionPassAdaptor(std::move(FPM)));
	MPM.run(M, MAM);

	return PreservedAnalyses::all();
}

}