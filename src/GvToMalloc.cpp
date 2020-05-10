#include "GvToMalloc.h"

using namespace llvm;
using namespace std;

namespace optim
{

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
        auto *bitCast = builder.CreateBitCast(malloc, type->getPointerTo(), "gv" + std::to_string(m_index)); // %gv1 = bitcast i8* %ma1 to type*

        auto constInt_value = dyn_cast<ConstantInt>(value);
        int64_t init_value = constInt_value->getSExtValue();
        if(init_value == 0) return bitCast;
        else
        {
            auto *store = builder.CreateStore(value, bitCast); // initialize the variable to original value if it was initialized with some value.
        }
        
    }

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


    void AddArgumentsToFunctionDef(Module &M, LLVMContext &Context, Function &f, Type *gv_type)
    {
        if(f.getName() == "main") return;
        else
        {
            Type *PtrType = Type::getInt8PtrTy(f.getContext());

            FunctionType *FTy = f.getFunctionType();
            SmallVector<Type *, 8> Params(FTy->param_begin(), FTy->param_end());
            Params.push_back(PtrType);
            FunctionType *NFTy = FunctionType::get(FTy->getReturnType(), Params, false);
            Function *NewFunc = RecreateFunction(&f, NFTy);
            
            NewFunc->setAttributes(
                f.getAttributes().addAttribute(f.getContext(), FTy->getNumParams()+1, Attribute::NoAlias));
            
            for(Function::arg_iterator Arg = f.arg_begin(), E = f.arg_end(), NewArg = NewFunc->arg_begin();
                        Arg != E; Arg++, NewArg++)
            {
                Arg->replaceAllUsesWith(NewArg);
                NewArg->takeName(Arg);
            }

            f.eraseFromParent();

            /*
            auto args = f.args();
            Argument* argArray;
            int index = 0;
            for(auto &arg : args)
            {
                f.addParamAttr(arg);
            }

            auto *tempFTy = f.getType();
            f.addParamAttr(0, )

             Function *tempF = Function::Create(tempFTy);
            */
        }
    }

    void AddArgumentsToCallInst(Instruction* malloc)
    {

    }

    PreservedAnalyses run(Module &M, ModuleAnalysisManager &MAM)
    {
        GvToMalloc *GTM;
        auto &Context = M.getContext();
        
        auto &GVs = M.getGlobalList();
        int m_index = 0;
        for(auto gv = GVs.begin(); gv != GVs.end(); gv++)
        {
            auto a = gv->getName();
            auto type = gv->getValueType();
            auto *value = gv->getInitializer();
            Value *malloc = GTM->MakeNewMalloc(M, Context, type, value, m_index);
            for(auto &f : M.functions())
            {
                GTM->AddArgumentsToFunctionDef(M, Context, f, type);
            }
            
            m_index++;
        }
    }
} // namespace backend