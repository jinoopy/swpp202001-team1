#include "VectorizedLoadAndStore.h"

#include "llvm/AsmParser/Parser.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/raw_os_ostream.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/IR/InstIterator.h"

#include "gtest/gtest.h"

using namespace llvm;
using namespace std;
using namespace optim;

class VectorizedLoadAndStoreTest : public testing::Test {

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

TEST_F(VectorizedLoadAndStoreTest, Test1) {
    parseAssembly("test-ir/input1_opt.ll");
    VectorizedLoadAndStorePass pass;
	for(Function &F : *M) {
		FunctionAnalysisManager FAM;
   		pass.run(F, FAM);
	}

    M->print(outs(), nullptr);
}

TEST_F(VectorizedLoadAndStoreTest, Test2) {
    parseAssembly("test-ir/input3_opt.ll");
    VectorizedLoadAndStorePass pass;
	for(Function &F : *M) {
		FunctionAnalysisManager FAM;
   		pass.run(F, FAM);
	}

    M->print(outs(), nullptr);
}

TEST_F(VectorizedLoadAndStoreTest, Test3) {
    parseAssembly("test-ir/input2_opt.ll");
    VectorizedLoadAndStorePass pass;
	for(Function &F : *M) {
		FunctionAnalysisManager FAM;
   		pass.run(F, FAM);
	}

    M->print(outs(), nullptr);
}

int main(int argc, char **argv) {
  ::testing::InitGoogleTest(&argc, argv);
  return RUN_ALL_TESTS();
}