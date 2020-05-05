#include "LivenessAnalysis.h"

using namespace llvm;
using namespace std;

namespace backend
{

//---------------------------------------------------------------
//class RegisterGraph
//---------------------------------------------------------------

RegisterGraph::RegisterGraph(Module &M)
{
    //find all value-results
    SearchAllArgInst(M);
    
    //Find live interval for all values
    vector<vector<bool>> liveInterval;
    liveInterval = LiveInterval(M);
    
    //Initialize adjList
    RegisterAdjList(liveInterval);

    ColorGraph();
}

#define isStore(I) (dyn_cast<StoreInst>(&I) != nullptr)
void RegisterGraph::SearchAllArgInst(Module &M)
{
    for (Function &F : M)
    {
        for (Argument &Arg : F.args())
        {
            values.push_back(&Arg);
        }
        for (BasicBlock &BB : F)
        {
            for (Instruction &I : BB)
            {
                if (!I.isTerminator() && !isStore(I))
                {
                    values.push_back(&I);
                }
            }
        }
    }
}

#define isArgument(V) (dyn_cast<Argument>(V) != nullptr)
vector<vector<bool>> RegisterGraph::LiveInterval(Module &M)
{

    map<Instruction *, vector<bool>> live;

    int N = values.size();

    //Initialize map 'live'
    for (Function &F : M)
    {
        for (BasicBlock &BB : F)
        {
            for (Instruction &I : BB)
            {
                live[&I] = vector<bool>(N);
            }
        }
    }

    //Search Liveness Interval for all values
    int i = 0;
    for (Value *V : values)
    {

        //'F': Function which 'V' is located.
        Function &F = *(isArgument(V) ? dyn_cast<Argument>(V)->getParent() : dyn_cast<Instruction>(V)->getParent()->getParent());
        //Get the DominatorTree for 'F'.
        DominatorTree DT(F);

        //'start': Where to start the search.
        Instruction &start = (isArgument(V) ? *(F.getEntryBlock().begin()) : *(dyn_cast<Instruction>(V)));

        LivenessSearch(start, *V, i, live, DT);
        i++;
    }

    vector<vector<bool>> result;

    for (Function &F : M)
    {
        for (BasicBlock &BB : F)
        {
            for (Instruction &I : BB)
            {
                result.push_back(live[&I]);
            }
        }
    }

    return result;
}

bool RegisterGraph::LivenessSearch(Instruction &curr, Value &find, int index, map<Instruction *, vector<bool>> &live, DominatorTree &DT)
{

    BasicBlock &BB = *(curr.getParent());

    bool isAlive = false;

    //if any dominated block uses find, 'isAlive' = true
    for (BasicBlock &succ : *BB.getParent()) {
        if (DT.dominates(&BB, &succ))
        {
            isAlive = LivenessSearch(*(succ.begin()), find, index, live, DT) || isAlive;
        }
    }
    
    //Search successors to check if 'find' is used further on
    for (BasicBlock *succ : successors(&BB))
    {
        //if successor uses 'find' in its phi node:
        for (PHINode &phi : succ->phis())
        {
            for (Use &use : phi.incoming_values())
            {
                Value *phival = use.get();
                if (phival == &find)
                {
                    isAlive = true;
                }
            }
        }
    }

    //Iterate through all instructions before curr
    //'curr' == mostly the first node of BB; 'find' in the first call
    for (auto it = BB.rbegin(); it != BB.rend(); ++it)
    {
        Instruction &I = *it;
        for (auto &op : I.operands())
        {
            //if 'find' is used, set 'find' alive
            if (&find == op.get())
            {
                isAlive = true;
            }
            //if 'find' is alive in I, (if 'find' == 'I' it is not alive yet)
            live[&I][index] = isAlive && (&I != &find);
        }
        if (&I == &curr)
        {
            break;
        }
    }

    return isAlive;
}

void RegisterGraph::RegisterAdjList(vector<vector<bool>>& liveInterval) {

    for(Value* value : values) {
        adjList[value] = set<Value*>();
    }

    for(vector<bool>& vec : liveInterval) {
        assert(vec.size() == values.size()
                && "values & liveInterval match");

        //if two registers are alive together in one instruction,
        for(int i = 0; i <vec.size(); ++i) {
            for(int j = i + 1; j < vec.size(); ++j) {
                if(vec[i] && vec[j]) {
                    //add to each other's adjacency list
                    adjList[values[i]].insert(values[j]);
                    adjList[values[j]].insert(values[i]);
                }
            }
        }
    }
}

void RegisterGraph::ColorGraph() {

    //calculates PEO for values + adjList
    vector<Value*> PEO = PerfectEliminationOrdering();

    //colors the graph greedily with PEO;
    greedyColoring(PEO);

}

vector<Value*> RegisterGraph::PerfectEliminationOrdering() {

    //Initially, Sigma contains a single set of all value in values.
    vector<set<Value*>> Sigma = { set<Value*>(values.begin(), values.end()) };
    vector<Value*> PEO;

    while(Sigma.size()>0) {
        //retrieve one value v from Sigma[0] and delete it.
        Value* v = *(Sigma[0].begin());
        Sigma[0].erase( Sigma[0].begin() );
        //if Sigma[0] is empty, remove it.
        if(Sigma[0].empty()) {
            Sigma.erase(Sigma.begin());
        }
        //push the popped value to result PEO vector.
        PEO.push_back(v);

        //for all members in Sigma, insert empty set
        for(auto it = Sigma.begin(); it != Sigma.end(); ++it) {
            Sigma.insert(it, set<Value*>());
        }
        //for all nodes connected to v,
        for(Value* w : adjList[v]) {
            //search if w is still in Sigma.
            for(auto it = Sigma.begin(); it != Sigma.end(); ++it) {
                auto wLoc = it->find(w);
                //if w exists in *it,
                if(wLoc != it->end()){
                    //move w to the set infront.
                    (it-1)->insert(w);
                    it->erase(wLoc);
                }
            }
        }
        for(auto it = Sigma.begin(); it != Sigma.end(); ++it) {
            if(it->empty()) {
                Sigma.erase(it);
            }
        }
    }

    reverse(PEO.begin(), PEO.end());
    return PEO;

}

//---------------------------------------------------------------
//class LivenessAnalysis
//---------------------------------------------------------------

RegisterGraph LivenessAnalysis::run(Module &M, ModuleAnalysisManager &MAM)
{
    return RegisterGraph(M);
}

} // namespace backend