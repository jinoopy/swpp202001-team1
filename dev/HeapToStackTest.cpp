#include "HeapToStack.h"

#include "llvm/AsmParser/Parser.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/raw_os_ostream.h"

#include "gtest/gtest.h"

using namespace llvm;
using namespace std;
using namespace optim;

class HeapToStackTest : public testing::Test
{

protected:
    LLVMContext Context;
    unique_ptr<Module> M;
    ModuleAnalysisManager MAM;
    map<StringRef, Value*> nameToValue;

    void parseAssembly(StringRef path) {
        SMDiagnostic Error;
        M = parseAssemblyFile(path, Error, Context);

        //If loading file failed:
        string errMsg;
        raw_string_ostream os(errMsg);
        Error.print("", os);
        ASSERT_TRUE(M) << os.str();

        for(Function& F : *M) {
            for(auto& Arg : F.args()) {
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

TEST_F(HeapToStackTest, Test1) {     // This test case has two global variables and two functions (main, foo).
    parseAssembly("test-ir/input1.ll");
    HeapToStackPass pass;
    pass.run(*M , MAM);

    M->print(outs(), nullptr);
    
    EXPECT_EQ(0, 0);
}

TEST_F(HeapToStackTest, Test2) {     // This test case has one global variable and two functions (main, foo).
    parseAssembly("test-ir/input2.ll");
    HeapToStackPass pass;
    pass.run(*M , MAM);

    M->print(outs(), nullptr);
    
    EXPECT_EQ(0, 0);
}

TEST_F(HeapToStackTest, Test3) {     // This test case has one global variable and one function (main).
    parseAssembly("test-ir/input3.ll");
    HeapToStackPass pass;
    pass.run(*M , MAM);

    M->print(outs(), nullptr);
    
    EXPECT_EQ(0, 0);
}

int main(int argc, char **argv) {
  ::testing::InitGoogleTest(&argc, argv);
  return RUN_ALL_TESTS();
}