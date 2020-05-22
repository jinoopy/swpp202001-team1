  
#include "LoopOptimPipe1.h"

#include "llvm/AsmParser/Parser.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/raw_os_ostream.h"

#include "gtest/gtest.h"

using namespace llvm;
using namespace std;
using namespace optim;

class LoopOptimPipe1Test : public testing::Test{
protected:
    LLVMContext Context;
    unique_ptr<Module> M;
    ModuleAnalysisManager MAM;
    
    void parseAssembly(StringRef path) {
        SMDiagnostic Error;
        M = parseAssemblyFile(path, Error, Context);

        string errMsg;
        raw_string_ostream os(errMsg);
        Error.print("", os);
        ASSERT_TRUE(M) << os.str();
    }

};

TEST_F(LoopOptimPipe1Test, Test1) {
    parseAssembly("test-ir/input1.ll");
    LoopOptimPipe1 pass;
    pass.run(*M , MAM);

    M->print(outs(), nullptr);
}

TEST_F(LoopOptimPipe1Test, Test2) {
    parseAssembly("test-ir/input2.ll");
    LoopOptimPipe1 pass;
    pass.run(*M , MAM);

    M->print(outs(), nullptr);
}

TEST_F(LoopOptimPipe1Test, Test3) {
    parseAssembly("test-ir/input3.ll");
    LoopOptimPipe1 pass;
    pass.run(*M , MAM);

    M->print(outs(), nullptr);
}

TEST_F(LoopOptimPipe1Test, Test4) {
    parseAssembly("test-ir/input4.ll");
    LoopOptimPipe1 pass;
    pass.run(*M , MAM);

    M->print(outs(), nullptr);
}

int main(int argc, char **argv) {
  ::testing::InitGoogleTest(&argc, argv);
  return RUN_ALL_TESTS();
}