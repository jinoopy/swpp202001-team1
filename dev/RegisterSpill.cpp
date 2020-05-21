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

//---------------------------------------------------------------
//class RegisterSpillPass
//---------------------------------------------------------------

PreservedAnalyses RegisterSpillPass::run(Module& M, ModuleAnalysisManager& MAM)
{
    this->M = &M;
    RegisterGraph RG(M);
    auto SpillCostResult = SpillCostAnalysis().run(M, MAM);

    for(Function& F : M) {
        if(F.isDeclaration()) continue;

        unsigned numColor = RG.getNumColors(&F);
        vector<float> spillCost = SpillCostResult[&F];

        //sort spillOrder while finding the Need-To-Be-Spilled set

        //total spilled registers
        unsigned spillCount;
        //isSpilled[c] = true if c should be spilled
        //FIXME: O(N^2) algorithm used here. Is there any better choice?
        vector<bool> isSpilled(RG.getNumColors(&F), false);
        for(spillCount = 0; spillCount <= numColor; spillCount++) {
            //numBuffer: # of leftover registers after assigning constantly-loaded colors
            int numBuffer = REGISTER_CAP-numColor+spillCount;
            if(numBuffer >= 1 && spilledEnough(numBuffer, isSpilled, &F, RG)) {
                break;
            }

            //Color which is most cheap to spill(among colors not spilled yet)
            unsigned minColor;
            unsigned minSpillCost = ~0; //MAX_UINT
            for(unsigned j = 0; j < numColor; j++) {
                if(!isSpilled[j] && minSpillCost > spillCost[j]) {
                    minColor = j;
                    minSpillCost = spillCost[j];
                }
            }
            isSpilled[minColor] = true;
        }

        //FIXME: Debug output
        outs() << "Spill analysis result of " << F.getName() << " : \n";
        outs() << "  Total colors: " << numColor << "\n";
        outs() << "  Spilled colors: " << spillCount << "\n  ";
        for(int i = 0; i < numColor; i++) {
            if(isSpilled[i]) {
                outs() << i << " ";
            }
        }
        outs() << "\n";

        //TODO
        //Implement the spilling transformation.
    }

    return PreservedAnalyses::all();
}

bool RegisterSpillPass::spilledEnough(unsigned numBuffer, vector<bool> isSpilled, Function* F, RegisterGraph& RG) {

    for(auto it = inst_begin(F); it != inst_end(F); ++it) {
        Instruction& I = *it;

        unsigned regCount = 0, memCount = 0;
        for(auto& use : I.operands()) {
            Value* operand = use.get();

            //If operand is not to be colored nor spilled, do nothing
            if(find(RG.getValues(F), operand) == RG.getValues(F).end()) continue;

            if(isSpilled[RG.getValueToColor(F, operand)]) {
                memCount++;
            }
            else {
                regCount++;
            }
        }
        if(memCount > numBuffer || regCount > REGISTER_CAP - numBuffer) {
            return false;
        }
    }


    return true;
}

}