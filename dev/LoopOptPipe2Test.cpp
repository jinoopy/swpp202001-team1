#include "LoopOptPipe2.h"

#include "llvm/AsmParser/Parser.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/raw_os_ostream.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/IR/InstIterator.h"

#include "gtest/gtest.h"

using namespace llvm;
using namespace std;
using namespace optim;

class LoopOptPipe2Test : public testing::Test {

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

TEST_F(LoopOptPipe2Test, Test1) {
    parseAssembly("test-ir/test_opt1.ll");
    LoopOptPipe2 pass;
	pass.run(*M, MAM);

    M->print(outs(), nullptr);
}

TEST_F(LoopOptPipe2Test, Test2) {
    parseAssembly("test-ir/test_opt2.ll");
    LoopOptPipe2 pass;
	pass.run(*M, MAM);

    M->print(outs(), nullptr);
}

int main(int argc, char **argv) {
  ::testing::InitGoogleTest(&argc, argv);
  return RUN_ALL_TESTS();
}