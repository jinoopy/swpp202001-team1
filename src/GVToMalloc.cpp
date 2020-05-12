#include "GVToMalloc.h"

using namespace llvm;
using namespace std;

namespace optim
{
    PreservedAnalyses GVToMalloc::run(Module &M, ModuleAnalysisManager &MAM)
    {
        auto &Context = M.getContext();
        
        auto &GVs = M.getGlobalList();
        int m_index = 0;
        vector<Value *> malloc;
        for(auto gv = GVs.begin(); gv != GVs.end(); gv++)
        {
            auto a = gv->getName();
            auto type = gv->getValueType();
            auto *value = gv->getInitializer();
            malloc.push_back(MakeNewMalloc(M, Context, type, value, m_index));
            m_index++;
        }
        // replace call instruction with new arguments.

        vector<Function*> old_functions;
        vector<Function*> new_functions;
        map<Function *, Function *> fMap; // By using fMap, we can call the new function(arguments changed function).
        for(auto &f : M.functions())
        {
            old_functions.push_back(&f);
        }
        for(auto &f : old_functions)
        {
            new_functions.push_back(&AddArgumentsToFunctionDef(M, Context, *f, malloc));  // after changing the definition(arguments) except main function.
            fMap[f] = new_functions[new_functions.size()-1];  // mapping old function pointer to new function pointer.
        }
        for(auto &f : new_functions)    // For each function, we will replace all of call instructions.
        {
            AddArgumentsToCallInst(fMap, *f, malloc);
        }
        int i =0;
        for(auto gv = GVs.begin(); gv != GVs.end(); gv++, i++)  // every gv,
        {
            for(auto &use : gv->uses()) // every use,
            {
                Function *func = dyn_cast<Instruction>(use.getUser())->getFunction();   // first get the function of use.
                if(func->getName() == "main")   // if the function is main function, use malloc.
                {
                    use.set(malloc[i]);
                }
                else    // if it is not main, use the function argument. find the argument by name.
                {
                    auto args = func->args();
                    for(auto j = args.begin(); j != args.end(); j++)
                    {
                        if(j->getName() == "gv" + std::to_string(i))
                        {
                            use.set(j);
                            break;
                        }
                    }
                }
            }
        }

        return PreservedAnalyses::all();
    }

    Value* GVToMalloc::MakeNewMalloc(Module &M, LLVMContext &Context, Type *type, llvm::Constant *value, int m_index)
    {
        auto size= type->getScalarSizeInBits();
        
        auto *MallocFTy = FunctionType::get(Type::getInt8PtrTy(Context), {Type::getInt64Ty(Context)}, false); // make malloc function
        Function *MallocF = Function::Create(MallocFTy, Function::ExternalLinkage,
                                                "malloc", M);

        auto main = M.getFunction("main"); // get main function for inserting malloc instruction.
        BasicBlock &Entry = main->getEntryBlock();
        auto *first = Entry.getFirstNonPHI();   //The position of starting instruction in this BasicBlock(Entry).
        IRBuilder<> builder(first);
        CallInst *malloc = builder.CreateCall(MallocF, ConstantInt::get(Type::getInt64Ty(Context), size), // %ma1 = call i8* @malloc(i64 size)
                                            "ma" + std::to_string(m_index));
        
        Value *bitCast = builder.CreateBitCast(malloc, type->getPointerTo(), "gv" + std::to_string(m_index)); // %gv1 = bitcast i8* %ma1 to type*

        auto constInt_value = dyn_cast<ConstantInt>(value); // getting The real value in C++ integer type not llvm value type. 
        int64_t init_value = constInt_value->getSExtValue();
        if(init_value != 0)
        {
            auto *store = builder.CreateStore(value, bitCast); // initialize the variable as the original value if it was initialized with some value.
        }
        return bitCast;
    }
     
    /*
    Function *RecreateFunction(Function *Func, FunctionType *NewType) {
        Function *NewFunc = Function::Create(NewType, Func->getLinkage());
        NewFunc->copyAttributesFrom(Func);
        Func->getParent()->getFunctionList().insert(Func->getIterator(), NewFunc);
        NewFunc->takeName(Func);
        NewFunc->getBasicBlockList().splice(NewFunc->begin(),
                                            Func->getBasicBlockList());
        Func->replaceAllUsesWith(
            ConstantExpr::getBitCast(NewFunc,
                                    Func->getFunctionType()->getPointerTo()));
        return NewFunc;
    }
    */

    // get all the malloc variables And add them as new arguments in function.
    Function& GVToMalloc::AddArgumentsToFunctionDef(Module &M, LLVMContext &Context, Function &f, vector<Value *> malloc)
    {
        if(f.getName() == "main") return f;
        else
        {
            FunctionType *FTy = f.getFunctionType();
            std::vector<Type *> Params;
            for(const Argument &I : f.args())   // add the original function arguments.
            {
                Params.push_back(I.getType());
            }
            for(int i = 0; i < malloc.size(); i++)  // add new function arguments.
            {
                Params.push_back(malloc[i]->getType());
            }
            
            FunctionType *NFTy = FunctionType::get(FTy->getReturnType(), Params, false);
            Function *NewFunc = Function::Create(NFTy, f.getLinkage(), f.getAddressSpace(), f.getName(), f.getParent());  // RecreateFunction(&f, NFTy);
            auto VMap = ValueToValueMapTy();
            Function::arg_iterator DestI = NewFunc->arg_begin();
            for(const Argument &I : f.args())   // set the name of original arguments to original name.
            {
                DestI->setName(I.getName());
                VMap[&I] = &*DestI++;
            }
            for(int i = 0; i < malloc.size(); i++, DestI++) // match the name of new arguments to the name of malloc variables in main function. 
            {
                DestI->setName(malloc[i]->getName());
            }
            SmallVector<ReturnInst*, 8> returns;
            CloneFunctionInto(NewFunc, &f, VMap, f.getSubprogram() != nullptr, returns, "");
            return *NewFunc;
        }
    }

    void GVToMalloc::AddArgumentsToCallInst(map<Function *, Function *> fMap, Function &f, vector<Value *> malloc)
    {
        for(auto I = inst_begin(f); I != inst_end(f); I++)
        {
            CallInst *cI = dyn_cast<CallInst>(&*I);
            IRBuilder<> builder((cI)); // make new instruction on the fCall instruction.
            vector<Value *> args; // origianl arguments + new malloc argument
            for(int i = 0; i < cI->getNumArgOperands(); i++)    // original arguments
            {
                args.push_back(cI->getArgOperand(i));
            }
            if(f.getName() == "main")   // In case of main function we should put the malloc variables directly but not arguments.
            {
                for(auto i = 0; i < malloc.size(); i++)
                {
                    args.push_back(malloc[i]);
                }
            }
            else    // In case of other functions, we should put the function arguments in call instruction. 
            {
                for(auto i = 0; i < malloc.size(); i++)
                {
                    for(auto &arg : f.args())
                    {
                        if(arg.getName() == malloc[i]->getName()) // malloc variable's name is same with function argument ex) f(arg0, arg1, arN, gv0 , gv1 .. gvN)
                        {
                            args.push_back(dyn_cast<Value>(&arg));
                        }
                    }
                }
            }
            auto *newInst_func = fMap[cI->getCalledFunction()];     // By using fMap, we can call the new function(arguments changed function).
            CallInst *newInst = builder.CreateCall(newInst_func, args, cI->getName());
            cI->eraseFromParent(); // after making new call instruction, erase the original instruction.
        }
    }
} // namespace backend