#include "LivenessAnalysis.h"

RegisterGraph LivenessAnalysis::run(Module &M, ModuleAnalysisManager &MAM) {
    
    vector<Value*> values = SearchAllArgInst(M);

    map<Instruction*, vector<bool>> live = LiveInterval(M, values);

    vector<vector<bool>> live_values;
    for(auto it = live.begin(); it != live.end(); ++it) {
        live_values.push_back(it->second);
    }

    RegisterGraph graph = RegisterClique(M, live_values);

    return graph;
}

#define isStore(I) (dyn_cast<StoreInst>(&I)!=nullptr)
vector<Value*> SearchAllArgInst(Module& M) {
    vector<Value*> values;
    for(Function& F : M) {
        for(Argument& Arg : F.args()) {
            values.push_back(&Arg);
        }
        for(BasicBlock& BB : F) {
            for(Instruction& I : BB) {
                if(!I.isTerminator() && !isStore(I)) {
                    values.push_back(&I);
                }
            }
        }
    }
    return values;
}

#define isArgument(V) (dyn_cast<Argument>(&V)!=nullptr)
map<Instruction*, vector<bool>> LiveInterval(Module& M, vector<Value*>& values) {

    map<Instruction*, vector<bool>> live;

    int N = values.size();

    //Initialize map 'live'
    for(Function& F : M) {
        for(BasicBlock& BB : F) {
            for(Instruction& I : BB) {
                live[&I] = vector<bool>(N);
            }
        }
    }

    //Search Liveness Interval for all values
    int i = 0;
    for(Value* Vptr : values) {
        Value& V = *Vptr;

        //'F': Function which 'V' is located.
        Function& F = *(isArgument(V) ?
                        dyn_cast<Argument>(V).getParent():
                        dyn_cast<Instruction>(V).getParent()->getParent());
        //Get the DominatorTree for 'F'.
        FunctionAnalysisManager FAM = FunctionAnalysisManager(true);
        DominatorTree& DT = FAM.getResult<DominatorTreeAnalysis>(F);
        
        //'start': Where to start the search.
        Instruction& start = (isArgument(V) ?
                            *(F.getEntryBlock().begin()):
                            dyn_cast<Instruction>(V));
        
        LivenessSearch(start, V, i, live, DT);
        i++;
    }

    return live;

}

bool LivenessSearch(Instruction& curr, Value& find, int index, map<Instruction*, vector<bool>>& live, DominatorTree& DT) {
    
    BasicBlock& BB = *(curr.getParent);

    bool isAlive = false;

    //Search successors to check if 'find' is used further on
    for(BasicBlock *succ : successors(&BB)) {
        //if any dominated block uses find, 'isAlive' = true
        if(DT.dominates(&BB, succ)) {
            isAlive = isAlive || LivenessSearch(*(succ->begin()), find, index, live, DT);
        }
        //if successor uses 'find' in its phi node:
        for(PHINode& phi: succ->phis()) {
            for(Use& use : phi.incoming_values()) {
                Value* phival = use.get();
                if(phival == &find) {
                    isAlive = true;
                }
            }
        }
    }

    //Iterate through all instructions before curr
    //'curr' == mostly the first node of BB; 'find' in the first call
    for(auto it = BB.rbegin(); &(*it) != &curr; ++it) {
        Instruction& I = *it;
        for(int i = 0; i < I.getNumOperands(); i++) {
            //if 'find' is used, set 'find' alive
            if(&find == I.getOperand(i)) {
                isAlive = true;
            }
            //if 'find' is alive in I, (if 'find' == 'I' it is not alive yet)
            live[&I][index] = isAlive && (&I != &find);
        }
    }

    return isAlive;

}