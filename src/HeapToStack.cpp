#include "HeapToStack.h"

using namespace llvm;
using namespace std;

namespace optim
{
    PreservedAnalyses HeapToStackPass::run(Module &M, ModuleAnalysisManager &MAM)
    {
        int numOfChange = 0;

        for(auto &f : M.functions())
        {
            if(f.getName() == "malloc") continue;
            outs() << "Start Function Loop : " << f.getName() << "\n";
            auto &entryBB = f.getEntryBlock();
            for(auto I = entryBB.begin(); I != entryBB.end(); I++)
            {
                auto cI = dyn_cast<CallInst>(I);
                outs() << "CallInst Found ! : " << cI->getCalledFunction()->getName() << "\n";
                if(cI && cI->getCalledFunction()->getName() == "malloc")
                {
                    outs() << "Start CheckCondition : " << cI->getName() << "\n";
                    if(CheckCondition(f, cI))
                    {
                        AllocaInst *alloca = ReplaceWithAlloca(cI, numOfChange);
                    }
                }
            }
        }
        return PreservedAnalyses::all();
    }
//  1. The size of malloc is constant
//  2. The malloc is not an array - check if the size is same with bitcast operand type.
//  3. This function should not return the malloc value.
//  4. The pointer should not be used after the end of the current function.
//     This will be determined by the following three conditions.
//  4-1. The address of this variable must not be stored to any pointer variable. - Store instruction(not destination but source value)
//  4-2. The address must not be copied by getelementptr instruction. - getelementptr instruction(operand)
//  4-3. The two conditions above should be considered on other functions called by the current function.
//  condition 3 will be checked on - IsStoredInFunction  
    bool HeapToStackPass::CheckCondition(Function &f, CallInst *malloc)
    {
        // condition 1
        if(!isa<ConstantInt>((malloc)->getArgOperand(0))) return false;
        outs() << "CheckCondition : " << malloc->getName() << " : isConstant " << isa<ConstantInt>((malloc)->getArgOperand(0)) <<"\n";
        // condition 2
        ConstantInt *const_size = dyn_cast<ConstantInt>(malloc->getArgOperand(0));
        auto malloc_size = const_size->getSExtValue(); // get the size of malloc
        Instruction *real_malloc = malloc; // if bitcast instruction is used to cast the malloc variable, change our object to bitcast instruction.
        for(auto &BB : f)
        {
            for(auto I = BB.begin(); I != BB.end(); I++)
            {
                auto *bitCast = dyn_cast<BitCastInst>(&*I);
                if(bitCast && bitCast->getOperand(0) == malloc)
                {
                    real_malloc = bitCast; // change from call instruction(malloc) to bitcast instruction
                    int cast_size_bit = GetPointerSize(bitCast->getType()->getPointerTo());
                    if(malloc_size * 8 != cast_size_bit) return false;  // If malloc size is an array, don't change it to alloca
                }
                // condition 3
                auto *returnInst = dyn_cast<ReturnInst>(&*I);
                if(returnInst && returnInst->getOperand(0) == malloc) return false;
            }
        }

        // condition 4
        return IsStoredInFunction(f, real_malloc, -1);
    }

    bool HeapToStackPass::IsStoredInFunction(Function &f, Instruction *mallocInst, int64_t argNum)
    {
        // get the malloc value from the current function.
        Value *malloc = nullptr;
        if(mallocInst != nullptr) malloc = mallocInst;
        else if(argNum != -1)
        {
            malloc = f.getArg(argNum);
        }

        for(auto &use : malloc->uses())
        {
            auto *I = dyn_cast<Instruction>(use.getUser());
            if(I->getFunction() != &f) continue;
            // condition 4-1 The address of this variable must not be stored to any pointer variable. - Store instruction(not destination but source value)
            if(isa<StoreInst>(I) && I->getOperand(0) == malloc) return false;
            // condition 4-2 The address must not be copied by getelementptr instruction. - getelementptr instruction(operand)
            if(isa<GetElementPtrInst>(I) && I->getOperand(0) == malloc) return false;
        }
        // condition 4-3 The two conditions above should be considered on other functions called by the current function.
        for(auto &BB : f)
        {
            for(auto I = BB.begin(); I != BB.end(); I++)
            {
                auto cI = dyn_cast<CallInst>(I);
                if(cI == nullptr) continue;
                int64_t argNum = 0;
                for(auto *Arg = cI->arg_begin(); Arg != cI->arg_end(); Arg++, argNum++)
                {
                    if(dyn_cast<Value>(Arg) == malloc)
                    {
                        if(!IsStoredInFunction(*(cI->getFunction()), nullptr, argNum)) return false;
                    }
                }
            }
        }
        return true;
    }

    AllocaInst* HeapToStackPass::ReplaceWithAlloca(CallInst *malloc, int num)
    {
        outs() << "Replace With Alloca : " << malloc->getName() << " Type : " << malloc->getType() << "\n";
        IRBuilder<> builder(malloc);
        auto &context = malloc->getFunction()->getContext();
        AllocaInst *alloca = builder.CreateAlloca(malloc->getType(), nullptr, malloc->getName() + "_" + std::to_string(num));
        outs() << "alloca Type : " << alloca->getType() << "\n";
        malloc->replaceAllUsesWith(alloca);
        malloc->eraseFromParent();
        return alloca;
    }
}
