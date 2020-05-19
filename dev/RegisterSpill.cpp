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

    RegisterGraph RG(M);

    for(Function &F : M) {
        if(F.isDeclaration()) continue;

        //Get ScalarEvolutionAnalysis
        FunctionAnalysisManager FAM;
        DominatorTree DT(F);
        LoopInfo LI(DT);

        TargetLibraryInfoImpl TLIImpl;
        TargetLibraryInfo TLI(TLIImpl, &F);
        AssumptionCache AC(F);
        ScalarEvolution SCE(F, TLI, AC, DT, LI);
        
        //Initialize cost count vector
        vector<float> cost(RG.getNumColors(&F));
        for(unsigned int c = 0; c < RG.getNumColors(&F); c++) {
            cost[c] = ALLOCA_COST;
            for(auto reg : RG.getColorToValue(&F)[c]) {
                
                cost[c] += STORE_COST * countLoopTripCount(dyn_cast<Instruction>(reg), SCE, LI);
                for(User* u : reg->users()) {
                    cost[c] += LOAD_COST * countLoopTripCount(dyn_cast<Instruction>(u), SCE, LI);
                }
                
            }
        }

        //Assign the calculated cost vector to the SpillCost
        SpillCost[&F] = cost;
    }
    return SpillCost;
}

unsigned SpillCostAnalysis::countLoopTripCount(Instruction* I, ScalarEvolution& SCE, LoopInfo& LI)
{
    //FIXME: Using the result of ScalarEvolution raises SegFault.
    //Default loop trip count is used for every deterministic/undetermined loops.
    unsigned count = 1;
    if(I == nullptr) return 1;
    for(Loop* L : LI) {
        if(L->contains(I)) {
            //unsigned tripCount = SCE.getSmallConstantTripCount(L);
            //useCount *= tripCount==0 ? DEFAULT_LOOP : tripCount;
            count *= DEFAULT_LOOP;
        }
    }
    return count;
}

}