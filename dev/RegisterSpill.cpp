#include "RegisterSpill.h"

namespace backend
{

//---------------------------------------------------------------
//class SpillCostAnalysis
//---------------------------------------------------------------

vector<float> SpillCostAnalysis::run(Module &M, ModuleAnalysisManager &MAM)
{
    RegisterGraph RG = MAM.getResult<LivenessAnalysis>(M);
    
}

}