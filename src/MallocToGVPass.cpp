#include "MallocToGVPass.h"

namespace optim
{

//---------------------------------------------------------------
//class MallocToGVPass
//---------------------------------------------------------------

PreservedAnalyses MallocToGVPass::run(Module &M, ModuleAnalysisManager &MAM)
{
    this->M = &M;
    this->MAM = &MAM;
    this->Context = &(M.getContext());

    //Int8Ptr type; constant.
    Type *Int8Ptr = IntegerType::get(*Context, 8)->getPointerElementType();

    FMain = M.getFunction("main");
    for (Instruction &I : FMain->getEntryBlock())
    {
        CallInst *cI = dyn_cast<CallInst>(&I);
        if (cI != nullptr && cI->getCalledFunction()->getName() == "malloc")
        {
            //final pointer passed to other functions
            Instruction* malloc = cI;
            //Bitcast instruction which transforms the type of malloc.
            //if no bitcast instruction performed, value of malloc() is used directly
            Instruction *bcI = getMallocType(cI);
            if(bcI == nullptr) {
                malloc = bcI;
            }
            Type *T = dyn_cast<PointerType>(bcI->getType());
            assert(T != nullptr && "return of malloc should be a pointer");

            //Save instruction which stores the initial value.
            StoreInst *stI = getMallocInitVal(cI);
            Constant *initVal = stI != nullptr ? dyn_cast<Constant>(stI->getValueOperand()) : nullptr;
            if (initVal == nullptr)
                continue;

            //create corresponding GV
            GlobalVariable *GV = new GlobalVariable(
                /*Module=*/M,
                /*Type=*/T,
                /*isConstant=*/false,
                /*Linkage=*/GlobalValue::InternalLinkage,
                /*Initializer=*/initVal,
                /*Name=*/(malloc->hasName() ? "gv." + malloc->getName() : ""));

            replaceMallocToGV(malloc, GV);
        }
    }
}

BitCastInst *MallocToGVPass::getMallocType(CallInst *malloc)
{
    for (Instruction &I : FMain->getEntryBlock())
    {
        BitCastInst *bcI = dyn_cast<BitCastInst>(&I);
        //bcI is an unary operation; getOperand(0)==transformed value
        if (bcI != nullptr && bcI->getOperand(0) == malloc)
        {
            return bcI;
        }
    }
    return nullptr;
}

StoreInst *MallocToGVPass::getMallocInitVal(Instruction *malloc)
{
    for (Instruction &I : FMain->getEntryBlock())
    {
        StoreInst *stI = dyn_cast<StoreInst>(&I);
        //bcI is an unary operation; getOperand(0)==transformed value
        if (stI != nullptr && stI->getPointerOperand() == malloc)
        {
            return stI;
        }
    }
    return nullptr;
}

void MallocToGVPass::replaceMallocToGV(Instruction * malloc, GlobalVariable *GV)
{
    map<Function*, Value*> equalArgs = findEqualPtrArgs(malloc);

    for(auto& p : equalArgs) {
        p.second->replaceAllUsesWith(GV);
    }
}

map<Function*, Value*> MallocToGVPass::findEqualPtrArgs(Value *Ptr)
{
    map<Function*, Value*> equalPtr;
    queue<Function *> qF;

    qF.push(FMain);
    equalPtr[FMain] = Ptr;
    while (!qF.empty())
    {
        //F in current search
        Function* F = qF.front(); qF.pop();
        //if equivalent ptr argument of Ptr is present, store the value.
        Value* ptrInF;
        if(find(equalPtr.begin(), equalPtr.end(), F) != equalPtr.end()) {
            ptrInF = equalPtr[F];
        }
        else ptrInF = nullptr;

        //for all CallInst in F,
        for (auto it = inst_begin(F); it != inst_end(F); ++it)
        {
            CallInst *cI = dyn_cast<CallInst>(&*it);
            if (cI)
            {
                //finds the index of ptrInF
                //f(op0, op1, ptrInF, op3) => 2
                unsigned int argN;
                for(argN = 0; argN<cI->getNumArgOperands(); argN++) {
                    if(cI->getArgOperand(argN) == ptrInF) {
                        break;
                    }
                }
                if(argN == cI->getNumArgOperands()) continue;

                //chooses the equivaent argument from called function
                //2 => define f(arg0, arg1, arg2) => arg2
                Function* calledF = cI->getCalledFunction();
                Argument* eqArg = calledF->getArg(argN);

                if(find(equalPtr.begin(), equalPtr.end(), calledF) != equalPtr.end()) {
                    assert(eqArg == equalPtr[calledF] && "wrong GV propagation");
                }
                else {
                    equalPtr[calledF] = eqArg;
                    qF.push(calledF);
                }
            }
        }
    }

    return equalPtr;
}

} // namespace optim
