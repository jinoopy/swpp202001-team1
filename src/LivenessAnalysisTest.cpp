#include "LivenessAnalysis.h"

#include "llvm/AsmParser/Parser.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/raw_os_ostream.h"

#include "gtest/gtest.h"

using namespace llvm;
using namespace std;
using namespace backend;

class RegisterGraphTest : public testing::Test
{

protected:
    LLVMContext Context;
    unique_ptr<Module> M;
    map<StringRef, Instruction*> instrs;

    void parseAssembly(StringRef path) {
        SMDiagnostic Error;
        M = parseAssemblyFile(path, Error, Context);

        //If loading file failed:
        string errMsg;
        raw_string_ostream os(errMsg);
        Error.print("", os);
        ASSERT_TRUE(M) << os.str();

        for(Function& F : *M) {
            for(auto I = inst_begin(F); I != inst_end(F); ++I) {
                if(I->hasName())
                    instrs[I->getName()] = &*I;
            }
        }
    }

};

TEST_F(RegisterGraphTest, NoCondColorGraphTest1) {
    parseAssembly("test-ir/input1.ll");
    RegisterGraph RG(*M);

    for(auto v : RG.getValues()) {
        for(auto w : RG.getAdjList(v)) {
            EXPECT_NE(RG.getValueToColor(v), RG.getValueToColor(w)) << "registers" << v->getName() << " " << w->getName() << " should not be the same color\n";
        }
    }
}

TEST_F(RegisterGraphTest, NoCondColorGraphTest2) {
    parseAssembly("test-ir/input2.ll");
    RegisterGraph RG(*M);

    for(auto v : RG.getValues()) {
        for(auto w : RG.getAdjList(v)) {
            EXPECT_NE(RG.getValueToColor(v), RG.getValueToColor(w)) << "registers" << v->getName() << " " << w->getName() << " should not be the same color\n";
        }
    }
}

int main(int argc, char **argv) {
  ::testing::InitGoogleTest(&argc, argv);
  return RUN_ALL_TESTS();
}