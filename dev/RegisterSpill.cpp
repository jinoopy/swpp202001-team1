#include "RegisterSpill.h"

namespace backend
{

//---------------------------------------------------------------
//class SpillCostAnalysis
//---------------------------------------------------------------

map<Function*, vector<float>> SpillCostAnalysis::run(Module &M, ModuleAnalysisManager &MAM)
{
    //Final result
    map<Function*, vector<float>> SpillCost;

    RegisterGraph RG = MAM.getResult<LivenessAnalysis>(M);

    for(Function &F : M) {
        //Get ScalarEvolutionAnalysis
        FunctionAnalysisManager FAM;
        ScalarEvolution& SCE = FAM.getResult<ScalarEvolutionAnalysis>(F);
        LoopInfo& LI = FAM.getResult<LoopAnalysis>(F);

        //Initialize cost count vector
        vector<float> cost(RG.getNumColors(&F));
        for(unsigned int c = 0; c < RG.getNumColors(&F); c++) {
            cost[c] = ALLOCA_COST;
            cost[c] += STORE_COST * RG.getColorToValue(&F)[c].size();
            for(auto reg : RG.getColorToValue(&F)[c]) {
                cost[c] += LOAD_COST * countUsesWithLoopTripCount(reg, SCE, LI);
            }
        }

        //Assign the calculated cost vector to the SpillCost
        SpillCost[&F] = cost;
    }
    return SpillCost;
}

unsigned SpillCostAnalysis::countUsesWithLoopTripCount(Value* value, ScalarEvolution& SCE, LoopInfo& LI)
{
    unsigned count = 0;
    for(Use& u : value->uses()) {
        unsigned useCount = 1;
        Instruction* I = dyn_cast<Instruction>(u.getUser());
        if(I == nullptr) continue;
        for(Loop* L : LI) {
            if(L->contains(I)) {
                unsigned tripCount = SCE.getSmallConstantMaxTripCount(L);
                useCount *= tripCount==0 ? DEFAULT_LOOP : tripCount;
            }
        }
        count += useCount;
    }
    return count;
}

}