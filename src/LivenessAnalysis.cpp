#include "LivenessAnalysis.h"

RegisterGraph LivenessAnalysis::run(Module &M, ModuleAnalysisManager &MAM) {
    
    vector<Value*> values = SearchAllArgInst(M);

    map<Value*, bool[]> live = LiveInterval(M, values);

    vector<bool[]> live_values;
    for(auto it = live.begin(); it != live.end(); ++it) {
        live_values.push_back(it->second);
    }

    RegisterGraph graph = RegisterClique(M, live_values);

    return graph;
}
