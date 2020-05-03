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

#define isStore(I) (dyn_cast<StoreInst>(&I)==nullptr)

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

map<Instruction*, vector<bool>> LiveInterval(Module& M, vector<Value*>& values) {

    map<Instruction*, vector<bool>> live;

    int N = values.size();

    for(Function& F : M) {
        for(BasicBlock& BB : F) {
            for(Instruction& I : BB) {
                live[&I] = vector<bool>();
            }
        }
    }

}