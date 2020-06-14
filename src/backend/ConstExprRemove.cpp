#include "ConstExprRemove.h"

using namespace std;
using namespace llvm;
using namespace backend;

namespace backend {

PreservedAnalyses ConstExprRemovePass::run(Module& M, ModuleAnalysisManager& MAM) {
    for(Function& F : M) {
        for(auto it = inst_begin(F); it != inst_end(F); ++it) {
            Instruction& I = *it;

            for(auto& use : I.operands()) {
                Value* operand = use.get();

                //ConstantExpr includes 'inlined' operations as in
                //store i32 %val, %i32* getelementptr...
                ConstantExpr* expr = dyn_cast<ConstantExpr>(operand);
                I.print(outs());
                if(expr) {
                    outs() << "\n";
                    Instruction* newI = expr->getAsInstruction();
                    newI->insertBefore(&I);
                    use.set(newI);
                }
            }
        }
    }
    return PreservedAnalyses::all();
}

}