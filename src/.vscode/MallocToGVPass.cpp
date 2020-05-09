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

    Function* FMain = M.getFunction("main");
    for(Instruction& I : FMain->getEntryBlock()) {
        CallInst* CallI = dyn_cast<CallInst>(&I);
        if(CallI != nullptr && CallI->getCalledFunction()->getName() == "malloc") {
            
            Type* T = I.getType();
            assert(T!=nullptr && "return of malloc should be a pointer");

            //TODO
            Constant* initVal = getInitVal(&I);

            //create corresponding GV
            GlobalVariable* GV = new GlobalVariable(
                /*Module=*/ M,
                /*Type=*/ T,
                /*isConstant=*/ false,
                /*Linkage=*/ GlobalValue::InternalLinkage,
                /*Initializer=*/ initVal,
                /*Name=*/ (I.hasName()? "gv."+I.getName() : "")
            );
            replaceAllUseToGV(&I, GV);
            //by AliasAnalysis, swap all uses of CallI to
        }
    }

}

} // namespace optim
