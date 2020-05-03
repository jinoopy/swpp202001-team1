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

    for(Function& F : M) {
        for(BasicBlock& BB : F) {
            for(Instruction& I : BB) {
                live[&I] = vector<bool>(N);
            }
        }
    }

    int i = 0;
    for(Value* Vptr : values) {
        Value& V = *Vptr;

        //F: Function which V is located.
        Function& F = *(isArgument(V) ?
                        dyn_cast<Argument>(V).getParent():
                        dyn_cast<Instruction>(V).getParent()->getParent());
        Instruction& start = (isArgument(V) ?
                            *(F.getEntryBlock().begin()):
                            dyn_cast<Instruction>(V));
        
        LivenessSearch(start, V, i, live);

    }

    return live;

}

void LivenessSearch(Instruction&, Value&, int, map<Instruction*, vector<bool>>&) {
    
}