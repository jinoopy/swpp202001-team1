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

TEST_F(RegisterGraphTest, LiveIntervalTest1) {
    parseAssembly("test-ir/input1.ll");
    RegisterGraph RG(*M);
}

int main(int argc, char **argv) {
  ::testing::InitGoogleTest(&argc, argv);
  return RUN_ALL_TESTS();
}