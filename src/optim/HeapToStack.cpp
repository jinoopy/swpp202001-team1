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
            if(f.isDeclaration()) continue;
            auto &entryBB = f.getEntryBlock();
            for(auto I = entryBB.begin(), E = entryBB.end(); I != E; I++)
            {
                auto cI = dyn_cast<CallInst>(I);
                if(cI && cI->getCalledFunction()->getName() == "malloc")
                {
                    if(CheckCondition(f, cI))
                    {
                        AllocaInst *alloc = ReplaceWithAlloca(cI, numOfChange);
                        numOfChange++;
                        I = entryBB.begin();
                        E = entryBB.end();
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
//  5. The pointer should not be casted to int - PtrToInt instruction - because it is a way to store the address.
//  condition 4 will be checked on - IsStoredInFunction  
    bool HeapToStackPass::CheckCondition(Function &f, CallInst *malloc)
    {
        // condition 1
        if(!isa<ConstantInt>((malloc)->getArgOperand(0))) return false;
        // condition 2
        ConstantInt *const_size = dyn_cast<ConstantInt>(malloc->getArgOperand(0));
        auto malloc_size = const_size->getSExtValue(); // get the size of malloc
        Instruction *real_malloc = malloc; // if bitcast instruction is used to cast the malloc variable, change our object to bitcast instruction.
        for(auto &u : malloc->uses())
        {
            auto *I = dyn_cast<Instruction>(u.getUser());
            auto *bitCast = dyn_cast<BitCastInst>(I);
            if(bitCast)
            {
                real_malloc = bitCast; // change from call instruction(malloc) to bitcast instruction
                int cast_size_bit = GetPointerSize(bitCast->getType());
                if(malloc_size * 8 != cast_size_bit) return false;  // If malloc size is an array, don't change it to alloca
            }
        }
        // If there is not bitcast instruction but malloc only, then check if the malloc_size is same with 8(return type of malloc function - i8*).
        if(real_malloc == malloc && malloc_size != 1) return false;

        // condition 3
        for(auto &u : real_malloc->uses())
        {
            auto *I = dyn_cast<Instruction>(u.getUser());
            auto *returnInst = dyn_cast<ReturnInst>(I);
            if(returnInst) return false;
        }
        
        // condition 4
        if(IsStoredInFunction(f, real_malloc, -1))
        {
            return true;
        }
        else
        {
            return false;
        }
        
    }

    bool HeapToStackPass::IsStoredInFunction(Function &f, Instruction *mallocInst, int argNum)
    {
        // get the malloc value from the current function.
        Value *malloc = nullptr;
        if(mallocInst != nullptr) malloc = mallocInst;
        else if(argNum != -1)
        {
            malloc = f.getArg(argNum);
        }
        // if this function is already tested on malloc's IsstoredInFunction, then return true.
        if(functions_done.find(malloc) != functions_done.end()) return true;
        functions_done[malloc] = &f;

        for(auto &use : malloc->uses())
        {
            auto *I = dyn_cast<Instruction>(use.getUser());
            if(I->getFunction() != &f) continue;
            // condition 4-1 The address of this variable must not be stored to any pointer variable. - Store instruction(not destination but source value)
            if(isa<StoreInst>(I) && I->getOperand(0) == malloc) return false;
            // condition 4-2 The address must not be copied by getelementptr instruction. - getelementptr instruction(operand)
            if(isa<GetElementPtrInst>(I) && I->getOperand(0) == malloc) return false;
            // condition 5 - PtrToInt instruction can save the address too.
            if(isa<PtrToIntInst>(I)) return false;
        }
        // condition 4-3 The two conditions above should be considered on other functions called by the current function.
        for(auto &BB : f)
        {
            for(auto I = BB.begin(); I != BB.end(); I++)
            {
                auto cI = dyn_cast<CallInst>(I);
                if(cI == nullptr) continue;
                int argNum = 0;
                for(auto *Arg = cI->arg_begin(); Arg != cI->arg_end(); Arg++, argNum++)
                {
                    if(dyn_cast<Value>(Arg) == malloc)
                    {
                        if(!IsStoredInFunction(*(cI->getCalledFunction()), nullptr, argNum)) return false;
                    }
                }
            }
        }
        return true;
    }
//  This function replace malloc instruction & bitcast instruction with new alloca instruction set to original conditions.
    AllocaInst* HeapToStackPass::ReplaceWithAlloca(CallInst *malloc, int num)
    {
        Instruction *real_malloc = malloc;
        for(auto &use : malloc->uses())
        {
            auto *bitCast = dyn_cast<BitCastInst>(use.getUser());
            if(bitCast) real_malloc = bitCast;
        }
        auto &context = malloc->getFunction()->getContext();
        IRBuilder<> builder(malloc);
        AllocaInst *alloc = builder.CreateAlloca(dyn_cast<PointerType>(real_malloc->getType())->getElementType(), nullptr, "alloca_" + malloc->getName());
        real_malloc->replaceAllUsesWith(alloc);
        if(real_malloc == malloc) malloc->eraseFromParent();
        else
        {
            real_malloc->eraseFromParent();
            malloc->eraseFromParent();
        }
        return alloc;
    }
}
