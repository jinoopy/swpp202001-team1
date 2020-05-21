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
            //count *= tripCount==0 ? DEFAULT_LOOP : tripCount;
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
    this->RG = RegisterGraph(M);
    auto SpillCostResult = SpillCostAnalysis().run(M, MAM);

    for(Function& F : M) {
        if(F.isDeclaration()) continue;

        unsigned numColor = RG.getNumColors(&F);
        vector<float> spillCost = SpillCostResult[&F];

        //sort spillOrder while finding the Need-To-Be-Spilled set

        //total spilled registers
        unsigned spillCount;
        //isSpilled[c] = true if c should be spilled
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

        //Create alloca instructions to spill colored IR registers
        BasicBlock& entryBlock = F.getEntryBlock();
        vector<AllocaInst*> spillAlloca(numColor);
        for(int c = 0; c < numColor; c++) {
            if(isSpilled[c]) {
                AllocaInst* allocC = new AllocaInst(Type::getInt64Ty(F.getContext()), 8, "color"+to_string(c), entryBlock.getFirstNonPHI());
                spillAlloca[c] = allocC;
            }
        }

        map<BasicBlock*, vector<bool>> finalRegState;
        spillRegister(isSpilled, spillAlloca, finalRegState, entryBlock);

        //update the 
        this->RG = RegisterGraph(M);
        assert(RG.getNumColors(&F) <= REGISTER_CAP && "needed registers should decrease under CAP after spilling");
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

void RegisterSpillPass::spillRegister(const vector<bool>& isSpilled, const vector<AllocaInst*>& spillAlloca, map<BasicBlock*, vector<bool>>& finalRegState, BasicBlock& BB)
{
    //if visited before, stop recursion.
    if(finalRegState.find(&BB) != finalRegState.end()) return;

    //Register File-loaded registers are marked as true.
    vector<bool> live(isSpilled.size());
    //If only predecessor, we assume that the liveness is preserved from the parent.
    if(pred_size(&BB) == 1) {
        assert(finalRegState.find(BB.getUniquePredecessor()) != finalRegState.end() && "If a predecessor of BB is unique, the ending state should be calculated");
        live = finalRegState[BB.getUniquePredecessor()];
    }
    //Else, safely, we do assume that every color is discarded.
    else {
        for(int i = 0; i < isSpilled.size(); i++) {
            live[i] = !isSpilled[i];
        }
    }

    for(Instruction& I : BB) {
        //check if I's operands are loaded on the register.
        for(auto& use : I.operands()) {
            Value* operand = use.getUser();
            //if operand has not a color, skip.
            if(find(RG.getValues().begin(), RG.getValues().end(), operand) == RG.getValues().end()) continue;

            //if the color is not loaded on register,
            unsigned opColor = RG.getValueToColor(BB.getParent())[operand];
            if(!live[opColor] && isSpilled[opColor]) {
                //modify the list of loaded registers.
                unsigned replacedColor = findReplaced();
                live[opColor] = true;
                live[replacedColor] = false;
                //insert the apparent load instruction and its supplementary ops(type casting)
                insertLoad(spillAlloca[opColor], I);
            }
        }

        //if I has a color,
        if(find(RG.getValues().begin(), RG.getValues().end(), &I) != RG.getValues().end()) {
            //modify the list of loaded registers
            unsigned replacedColor = findReplaced();
            live[RG.getValueToColor(BB.getParent())[&I]] = true;
            live[replacedColor] = false;
            //store the result to the apparent alloca'd memory.
            unsigned IColor = RG.getValueToColor(BB.getParent())[&I];
            insertStore(spillAlloca[IColor], I);
        }
    }

    finalRegState[&BB] = live;

    for(auto it = pred_begin(&BB); it != pred_end(&BB); ++it) {
        spillRegister(isSpilled, spillAlloca, finalRegState, **it);
    }
}

}