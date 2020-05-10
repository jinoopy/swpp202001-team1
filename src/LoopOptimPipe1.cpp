#include "LoopOptimPipe1.h"

using namespace llvm;
using namespace std;

namespace optim {

PreservedAnalyses LoopOptimPipe1::run(Module &M, ModuleAnalysisManager &MAM) {    
    for(Module::iterator f = M.begin(), fend = M.end(); f != fend; ++f) {
            LoopInfo &LI = getAnalysis<LoopInfoWrapperPass>().getLoopInfo();
            for(Loop &L : LI) {
                LoopSimplifyCFGPass::run(&L, LoopAnalysisManager &AM, LoopStandardAnalysisResults &AR, LPMUpdater &LPMU);
                LICMPass::LICMPass()
                
                //rotate
                
                //unswitching
            }
     }
    return PreservedAnalyses::all();
}

}
