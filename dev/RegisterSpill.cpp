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
    RegisterGraph tRG(M);
    this->RG = &tRG;
    auto SpillCostResult = SpillCostAnalysis().run(M, MAM);

    for(Function& F : M) {
        if(F.isDeclaration()) continue;

        //If spill not needed, do nothing for the function.
        unsigned numColor = RG->getNumColors(&F);
        if(numColor <= REGISTER_CAP) continue;

        vector<float> spillCost = SpillCostResult[&F];
        
        //sort spillOrder while finding the Need-To-Be-Spilled set

        //total spilled registers
        unsigned spillCount;
        //isSpilled[c] = true if c should be spilled
        vector<bool> isSpilled(RG->getNumColors(&F), false);
        int numBuffer;
        for(spillCount = 0; spillCount <= numColor; spillCount++) {
            //numBuffer: # of leftover registers after assigning constantly-loaded colors
            numBuffer = REGISTER_CAP-numColor+spillCount;
            if(numBuffer >= 1 && spilledEnough(numBuffer, isSpilled, &F)) {
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
        assert(numBuffer>0);

        //Create alloca instructions to spill colored IR registers
        BasicBlock& entryBlock = F.getEntryBlock();
        vector<AllocaInst*> spillAlloca(numColor);
        for(int c = 0; c < numColor; c++) {
            if(isSpilled[c]) {
                AllocaInst* allocC = new AllocaInst(Type::getInt64Ty(F.getContext()), 0, "color"+to_string(c), entryBlock.getFirstNonPHI());
                spillAlloca[c] = allocC;
            }
        }
        for(BasicBlock& BB : F) {
            spillRegister(numBuffer, isSpilled, spillAlloca, BB);
        }

        tRG = RegisterGraph(M);
        this->RG = &tRG;
    }

    return PreservedAnalyses::all();
}

bool RegisterSpillPass::spilledEnough(unsigned numBuffer, vector<bool> isSpilled, Function* F) {

    for(auto it = inst_begin(F); it != inst_end(F); ++it) {
        Instruction& I = *it;

        unsigned regCount = 0, memCount = 0;
        for(auto& use : I.operands()) {
            Value* operand = use.get();

            //If operand is not to be colored nor spilled, do nothing
            if(RG->findValue(operand) == -1) continue;

            if(isSpilled[RG->getValueToColor(F, operand)]) {
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

void RegisterSpillPass::spillRegister(unsigned numBuffer, const vector<bool>& isSpilled, const vector<AllocaInst*>& spillAlloca, BasicBlock& BB)
{
    for(Instruction& I : BB) {
        //for phi nodes,
        if(isa<PHINode>(I)) {
            PHINode& phi = *(dyn_cast<PHINode>(&I));
            for(unsigned i = 0; i < phi.getNumIncomingValues(); i++) {
                BasicBlock* phiBB = phi.getIncomingBlock(i);
                Value* phiV = phi.getIncomingValue(i);

                //if operand has no color, skip.
                if(RG->findValue(phiV) == -1) continue;
                unsigned opColor = RG->getValueToColor(BB.getParent())[phiV];
                if(isSpilled[opColor]) {
                    //insert the apparent load instruction and its supplementary ops(type casting)
                    insertLoad(phi.getOperandUse(PHINode::getOperandNumForIncomingValue(i)), spillAlloca[opColor], phiBB->getTerminator());
                }
            }
        }
        //for other instructions,
        else {
            //check if I's operands are loaded on the register.
            for(auto& use : I.operands()) {
                Value* operand = use.get();
                //if operand has no color, skip.
                if(RG->findValue(operand) == -1) continue;

                //if the color is not loaded on register,
                unsigned opColor = RG->getValueToColor(BB.getParent())[operand];
                if(isSpilled[opColor]) {
                    //insert the apparent load instruction and its supplementary ops(type casting)
                    insertLoad(use, spillAlloca[opColor], &I);
                }
            }
        }
        //if I has a spilled color,
        if(RG->findValue(&I) != -1) {
            unsigned IColor = RG->getValueToColor(BB.getParent())[&I];
            if(isSpilled[IColor]) {
                //store the result to the apparent alloca'd memory.
                insertStore(&I, spillAlloca[IColor], I.getNextNode());
            }
        }
    }
}

void RegisterSpillPass::insertLoad(Use& target, AllocaInst* loadFrom, Instruction* insertBefore) {
    StringRef nameStr = target.get()->getName();
    
    //Loads from the 'loadFrom' pointer, which stores equally colored value.
    LoadInst* loadInst = new LoadInst(loadFrom, nameStr+".temp.l", insertBefore);

    //Create an appropriate type conversing instruction(inttoptr, trunc, ...)
    Value* typeConv;
    Type* targetType = target.get()->getType();
    
    LLVMContext& Context = M->getContext();
    if(targetType == Type::getInt64Ty(Context)) {
        //no type conversion instruction should be created.
        typeConv = loadInst;
    }
    else if(targetType->isIntegerTy()) {
        //trunc operation can shrink the size of an integer.
        typeConv = new TruncInst(loadInst, targetType, nameStr + ".temp.l", insertBefore);
    }
    else if(targetType->isPointerTy()) {
        //inttoptr operation can change i64 to pointer.
        typeConv = new IntToPtrInst(loadInst, targetType, nameStr + ".temp.l", insertBefore);
    }
    else {
        assert(false && "type should be IntegerTy or PointerTy");
    }

    //Replace the original usage to the new one.
    target.set(typeConv);
}

void RegisterSpillPass::insertStore(Value* storeVal, AllocaInst* storeAt, Instruction* insertBefore) {
    StringRef nameStr = storeVal->getName();

    //Create an appropriate type conversing instruction to i64
    Value* typeConv;
    Type* targetType = storeVal->getType();

    LLVMContext& Context = M->getContext();
    Type* i64Ty = Type::getInt64Ty(Context);
    if(targetType == i64Ty) {
        //no type conversion instruction should be created.
        typeConv = storeVal;
    }
    else if(targetType->isIntegerTy()) {
        //zext instructions zero-extend smaller integers to i64.
        typeConv = new ZExtInst(storeVal, i64Ty, nameStr+".temp.s", insertBefore);
    }
    else if(targetType->isPointerTy()) {
        //ptrtoint instructions convert pointer to i64.
        typeConv = new PtrToIntInst(storeVal, i64Ty, nameStr+".temp.s", insertBefore);
    }
    else {
        assert(false && "type should be IntegerTy or PointerTy");
    }

    //Create storeInst to store the value in appropriate alloca inst.
    StoreInst* storeinst = new StoreInst(typeConv, storeAt, insertBefore);
}

}