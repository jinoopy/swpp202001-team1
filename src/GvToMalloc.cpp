#include "GvToMalloc.h"

using namespace llvm;
using namespace std;

namespace optim
{
    PreservedAnalyses GvToMalloc::run(Module &M, ModuleAnalysisManager &MAM)
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
        for(auto &f : M.functions())
        {
            AddArgumentsToFunctionDef(M, Context, f, malloc);
            for(auto *usr : f.users())
            {
                CallInst *cI = dyn_cast<CallInst>(usr);
                if(cI != nullptr)
                {
                    AddArgumentsToCallInst(f, cI, malloc);
                }
            }
        }
    }

    Value* GvToMalloc::MakeNewMalloc(Module &M, LLVMContext &Context, Type *type, llvm::Constant *value, int m_index)
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
    void GvToMalloc::AddArgumentsToFunctionDef(Module &M, LLVMContext &Context, Function &f, vector<Value *> malloc)
    {
        if(f.getName() == "main") return;
        else
        {
            FunctionType *FTy = f.getFunctionType();
            std::vector<Type *> Params;
            for(const Argument &I : f.args())
            {
                Params.push_back(I.getType());
            }
            for(int i = 0; i < malloc.size(); i++)
            {
                Params.push_back(malloc[i]->getType());
            }
            
            FunctionType *NFTy = FunctionType::get(FTy->getReturnType(), Params, false);
            Function *NewFunc = Function::Create(NFTy, f.getLinkage(), f.getAddressSpace(), f.getName(), f.getParent());  // RecreateFunction(&f, NFTy);
            auto VMap = ValueToValueMapTy();
            Function::arg_iterator DestI = NewFunc->arg_begin();
            for(const Argument &I : f.args())
            {
                DestI->setName(I.getName());
                VMap[&I] = &*DestI++;
            }
            for(int i = 0; i < malloc.size(); i++, DestI++)
            {
                DestI->setName(malloc[i]->getName());
            }
            SmallVector<ReturnInst*, 8> returns;
            CloneFunctionInto(NewFunc, &f, VMap, f.getSubprogram() != nullptr, returns, "");
        }
    }

    void GvToMalloc::AddArgumentsToCallInst(Function &f, CallInst* fCall, Value *malloc)
    {
        IRBuilder<> builder((fCall)); // make new instruction on the fCall instruction.
        vector<Value *> args; // existing arguments + new malloc argument
        for(int i = 0; i < fCall->getNumArgOperands(); i++)
        {
            args.push_back(fCall->getArgOperand(i));
        }
        args.push_back(malloc);
        CallInst *newInst = builder.CreateCall(&f, args, fCall->getName());
        fCall->eraseFromParent(); // after making new call instruction, erase the original instruction.
    }
} // namespace backend