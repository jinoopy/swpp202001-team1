#include "StackHeapAccessGroup.h"

#define DEFAULT_CHECK(M) (M)->print(outs(), nullptr), cout << verifyModule(*M) << endl

#include "llvm/AsmParser/Parser.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/raw_os_ostream.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/Verifier.h"

#include "gtest/gtest.h"

using namespace llvm;
using namespace std;
using namespace optim;

class StackHeapAccessGroupTest : public testing::Test {
protected:
	LLVMContext Context;
	unique_ptr<Module> M;
	ModuleAnalysisManager MAM;
	map<StringRef, Value*> nameToValue;

	void parseAssembly(StringRef path) {
		SMDiagnostic Error;
		M = parseAssemblyFile(path, Error, Context);

		// If loading file failed:
		string errMsg;
		raw_string_ostream os(errMsg);
		Error.print("", os);
		ASSERT_TRUE(M) << os.str();

		for(Function &F : *M) {
			for(auto &Arg : F.args()) {
				if(Arg.hasName()) {
					nameToValue[Arg.getName()] = &Arg;
				}
			}
			for(auto I = inst_begin(F); I != inst_end(F); ++I) {
				if(I->hasName()) {
					nameToValue[I->getName()] = &(*I);
				}
			}
		}
	}

};

TEST_F(StackHeapAccessGroupTest, Test1) {
	parseAssembly("test-ir/test1.ll");
	StackHeapAccessGroupPass pass;

	for(Function &F : *M) {
		FunctionAnalysisManager FAM;
		pass.run(F, FAM);
	}

	DEFAULT_CHECK(M);
}


TEST_F(StackHeapAccessGroupTest, Test2) {
	parseAssembly("test-ir/test2.ll");
	StackHeapAccessGroupPass pass;

	for(Function &F : *M) {
		FunctionAnalysisManager FAM;
		pass.run(F, FAM);
	}

	DEFAULT_CHECK(M);
}

TEST_F(StackHeapAccessGroupTest, Test3) {
	parseAssembly("test-ir/test3.ll");
	StackHeapAccessGroupPass pass;

	for(Function &F : *M) {
		FunctionAnalysisManager FAM;
		pass.run(F, FAM);
	}

	DEFAULT_CHECK(M);
}

TEST_F(StackHeapAccessGroupTest, Test4) {
	parseAssembly("test-ir/test4.ll");
	StackHeapAccessGroupPass pass;

	for(Function &F : *M) {
		FunctionAnalysisManager FAM;
		pass.run(F, FAM);
	}

	DEFAULT_CHECK(M);
}

int main(int argc, char **argv) {
	::testing::InitGoogleTest(&argc, argv);
	return RUN_ALL_TESTS();
}