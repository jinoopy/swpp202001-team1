#include "LoopOptimPipe1.h"

using namespace llvm;
using namespace std;

namespace optim {

PreservedAnalyses LoopOptimPipe1::run(Module &M, ModuleAnalysisManager &MAM) {   
    PassManager<Function, FunctionAnalysisManager> FPM;
    FPM.addPass(LoopSimplify());

    PassManager<Loop, LoopAnalysisManager> LPM;
    LPM.addPass(*createLCSSAPass());
    LPM.addPass(*createLICMPass());
    LPM.addPass(*createLoopRotatePass(10));
    LPM.addPass(*createLoopUnswitchPass(OS, hasBranchDivergence));

    for(Function &F : M) {
        FunctionAnalysisManager FAM;
        FPM.run(F, FAM);
        LoopInfo &LI = getAnalysis<LoopInfoWrapperPass>().getLoopInfo();
        for(Loop &L : LI) {
            LoopAnalysisManager LAM;
            LPM.run(L, LAM);
        }
    }
    return PreservedAnalyses::all();
}

}


//LPPassManager LPM;
//createLoopSimplifyCFGPass();
//LICMPass::LICMPass();
//createLoopRotatePass(maxHeaderSize);
//createLoopUnswitchPass(OS, hasBranchDivergence);