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
        CallInst* malloc = dyn_cast<CallInst>(&I);
        if(malloc != nullptr && malloc->getCalledFunction()->getName() == "malloc") {
            
            Type* T = getMallocType(malloc);
            assert(T!=nullptr && "return of malloc should be a pointer");

            //TODO
            Constant* initVal = getMallocInitVal(malloc);

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
            //by AliasAnalysis, swap all uses of CallI to
        }
    }

}

} // namespace optim
