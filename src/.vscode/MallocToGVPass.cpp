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
    Type* Int8Ptr = IntegerType::get(*Context, 8)->getPointerElementType();

    FMain = M.getFunction("main");
    for(Instruction& I : FMain->getEntryBlock()) {
        CallInst* malloc = dyn_cast<CallInst>(&I);
        if(malloc != nullptr && malloc->getCalledFunction()->getName() == "malloc") {
            
            //Bitcast instruction which transforms the type of malloc.
            BitCastInst* bcI = getMallocType(malloc);
            //if no bitcast instruction performed, pointer is default int8*
            Type* T = bcI != nullptr ? dyn_cast<PointerType>(bcI->getType()) : Int8Ptr;
            assert(T!=nullptr && "return of malloc should be a pointer");


            //Store instruction which stores the initial value.
            StoreInst* stI = getMallocInitVal(malloc);
            Constant* initVal = stI != nullptr ? dyn_cast<Constant>(stI->getValueOperand()) : nullptr;
            if(initVal == nullptr) continue;

            //create corresponding GV
            GlobalVariable* GV = new GlobalVariable(
                /*Module=*/ M,
                /*Type=*/ T,
                /*isConstant=*/ false,
                /*Linkage=*/ GlobalValue::InternalLinkage,
                /*Initializer=*/ initVal,
                /*Name=*/ (malloc->hasName()? "gv."+malloc->getName() : "")
            );

            replaceMallocToGV(malloc, GV);
        }
    }

}

BitCastInst* MallocToGVPass::getMallocType(CallInst* malloc) {
    for(Instruction& I : FMain->getEntryBlock()) {
        BitCastInst* bcI = dyn_cast<BitCastInst>(&I);
        //bcI is an unary operation; getOperand(0)==transformed value
        if(bcI != nullptr && bcI->getOperand(0)==malloc) {
            return bcI;
        }
    }
    return nullptr;
}

StoreInst* MallocToGVPass::getMallocInitVal(CallInst* malloc) {
    for(Instruction& I : FMain->getEntryBlock()) {
        StoreInst* stI = dyn_cast<StoreInst>(&I);
        //bcI is an unary operation; getOperand(0)==transformed value
        if(stI != nullptr && stI->getPointerOperand()==malloc) {
            return stI;
        }
    }
    return nullptr;
}

void MallocToGVPass::replaceMallocToGV(CallInst*, GlobalVariable*) {

}

} // namespace optim
