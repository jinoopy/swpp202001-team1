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

#define P pair<Value*, Value*>
TEST_F(RegisterGraphTest, CoallocGraphTest1) {
    parseAssembly("test-ir/input3.ll");
    vector<pair<Value*, Value*>> coallocate = {
        P(nameToValue["r0"], nameToValue["r5"]),
        P(nameToValue["r1"], nameToValue["r6"]),
    };
    RegisterGraph RG(*M, coallocate);

    for(auto v : RG.getValues()) {
        for(auto w : RG.getAdjList(v)) {
            EXPECT_NE(RG.getValueToColor(v), RG.getValueToColor(w)) << "registers" << v->getName() << " " << w->getName() << " should not be the same color\n";
        }
    }
    for(auto p : coallocate) {
        EXPECT_EQ(RG.getValueToColor(p.first), RG.getValueToColor(p.second));
    }
}

int main(int argc, char **argv) {
  ::testing::InitGoogleTest(&argc, argv);
  return RUN_ALL_TESTS();
}