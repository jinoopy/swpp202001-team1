#include "VectorizedLoadAndStore.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/PatternMatch.h"
#include "llvm/IR/Instructions.h"

#include <map>
#include <set>
#include <algorithm>

using namespace llvm;
using namespace std;

namespace optim {

PreservedAnalyses run(Function &F, FunctionAnalysisManager &AM) {
	// 총 세 번 반복
	for(int __iter__ = 0; __iter__ < 3; __iter__++) {
		for(auto &BB : F) {
			// Load/Store[i]: i(1<<(i+3)) type의 load/store instruction 모아놓는 std::vector
			vector<Instruction> Load[3], Store[3];
			for(auto &I : BB) {
				LoadInst *load = dyn_cast<LoadInst>(&I);
				StoreInst *store = dyn_cast<StoreInst>(&I);
				if(load) {
					Type *Ty = load->getType();
					if(Ty->isIntegerTy(8)) {
						Load[0].push_back(I);
					} else if(Ty->isIntegerTy(16)) {
						Load[1].push_back(I);
					} else if(Ty->isIntegerTy(32)) {
						Load[2].push_back(I);
					}
				} else if(store) {
					Type *Ty = store->getType();
					if(Ty->isIntegerTy(8)) {
						Store[0].push_back(I);
					} else if(Ty->isIntegerTy(16)) {
						Store[1].push_back(I);
					} else if(Ty->isIntegerTy(32)) {
						Store[2].push_back(I);
					}
				}
			}
			for(int i = 0; i < 3; i++) {
				set<unsigned> ptrs;
				// Load[i]에 있는 instruction의 pointer를 찾아서 set에 집어넣음 -> 이러면 크기 순으로 정렬됨
				for(auto &it : Load[i]) {
					Value *ptr = getLoadStorePointerOperand(&it);
					ptrs.insert(dyn_cast<LoadInst>(&it)->getPointerOperand()->getType()->getPointerAddressSpace());
				}
				// Load[i] 보면서 두 개가 consecutive하면(= Load[i] operand의 주소랑 바로 인접한 다음 주소도 set에 있으면) 
				// 하나로 합칠 수 있음
				// i8 두 개가 연달아 있으면 i16 하나로 고칠 수 있고, i16 두 개는 i32로, ...

				// 이렇게 하는 이유(set으로 정렬해서 처리하는 이유)는, a[i], a[i+1], ..., 꼴이 아닌 a[i], a[i-1], ..., 꼴로 접근할 수도 있기 때문임
				// 앞의 경우에는 Load[i]만 순서대로 봤을 때 처리하기 어려울 것 같아서 주소 순으로 정렬함.
				for(auto &it : Load[i]) {
					// 만약 consecutive memory access를 찾으면, 다음 작업 실행.
					// 1) 해당 load/store의 operand pointer를 받아오는 연산을 상위 type으로 변경(i8->i16, i16->i32, ...)
					// 2) 상위 type의 pointer로부터 값을 load/store
					// 3) 원래 load/store를 2)에서 구한 값을 이용해 분배 (replaceAllUsesWith() 쓰면 될 것 같음)
				}
			}
		}
	}

	return PreservedAnalyses::all();
}

}