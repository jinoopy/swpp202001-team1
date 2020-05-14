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

TEST_F(RegisterGraphTest, ColorGraphTest1) {
    parseAssembly("test-ir/input1.ll");
    RegisterGraph RG(*M);

    for(Function& F : *M) {
        if(RG.getNumColors(&F) == 0) continue;
        outs() << F.getName() << " " << RG.getNumColors(&F) << " colors needed\n";
        for(int i = 0; i < RG.getNumColors(&F); i++) {
            outs() << "color " << i << " : ";
            for(Value* v : RG.getColorToValue(&F)[i]) {
                outs() << (v->hasName() ? v->getName() : "no-name") << " ";
            }
            outs() << "\n";
        }
        outs() << "\n";
        for(Value* v : RG.getValues(&F)) {
            for(auto w : RG.getAdjList(v)) {
                EXPECT_NE(RG.getValueToColor(&F, v), RG.getValueToColor(&F, w)) << "registers" << v->getName() << " " << w->getName() << " should not be the same color\n";
            }
        }
    }
}

TEST_F(RegisterGraphTest, ColorGraphTest2) {
    parseAssembly("test-ir/input2.ll");
    RegisterGraph RG(*M);

    for(Function& F : *M) {
        if(RG.getNumColors(&F) == 0) continue;
        outs() << F.getName() << " " << RG.getNumColors(&F) << " colors needed\n";
        for(int i = 0; i < RG.getNumColors(&F); i++) {
            outs() << "color " << i << " : ";
            for(Value* v : RG.getColorToValue(&F)[i]) {
                outs() << (v->hasName() ? v->getName() : "no-name") << " ";
            }
            outs() << "\n";
        }
        for(Value* v : RG.getValues(&F)) {
            for(auto w : RG.getAdjList(v)) {
                EXPECT_NE(RG.getValueToColor(&F, v), RG.getValueToColor(&F, w)) << "registers" << v->getName() << " " << w->getName() << " should not be the same color\n";
            }
        }
    }
}

TEST_F(RegisterGraphTest, ColorGraphTest3) {
    parseAssembly("test-ir/input3.ll");
    RegisterGraph RG(*M);

    for(Function& F : *M) {
        if(RG.getNumColors(&F) == 0) continue;
        outs() << F.getName() << " " << RG.getNumColors(&F) << " colors needed\n";
        for(int i = 0; i < RG.getNumColors(&F); i++) {
            outs() << "color " << i << " : ";
            for(Value* v : RG.getColorToValue(&F)[i]) {
                outs() << (v->hasName() ? v->getName() : "no-name") << " ";
            }
            outs() << "\n";
        }
        outs() << "\n";
        for(Value* v : RG.getValues(&F)) {
            for(auto w : RG.getAdjList(v)) {
                EXPECT_NE(RG.getValueToColor(&F, v), RG.getValueToColor(&F, w)) << "registers" << v->getName() << " " << w->getName() << " should not be the same color\n";
            }
        }
    }
}

TEST_F(RegisterGraphTest, ColorGraphTest4) {
    parseAssembly("test-ir/input4.ll");
    RegisterGraph RG(*M);

    for(Function& F : *M) {
        if(RG.getNumColors(&F) == 0) continue;
        outs() << F.getName() << " " << RG.getNumColors(&F) << " colors needed\n";
        for(int i = 0; i < RG.getNumColors(&F); i++) {
            outs() << "color " << i << " : ";
            for(Value* v : RG.getColorToValue(&F)[i]) {
                outs() << (v->hasName() ? v->getName() : "no-name") << " ";
            }
            outs() << "\n";
        }
        outs() << "\n";
        for(Value* v : RG.getValues(&F)) {
            for(auto w : RG.getAdjList(v)) {
                EXPECT_NE(RG.getValueToColor(&F, v), RG.getValueToColor(&F, w)) << "registers" << v->getName() << " " << w->getName() << " should not be the same color\n";
            }
        }
    }
}

TEST_F(RegisterGraphTest, ColorGraphTest5) {
    parseAssembly("test-ir/input5.ll");
    RegisterGraph RG(*M);

    for(Function& F : *M) {
        if(RG.getNumColors(&F) == 0) continue;
        outs() << F.getName() << " " << RG.getNumColors(&F) << " colors needed\n";
        for(int i = 0; i < RG.getNumColors(&F); i++) {
            outs() << "color " << i << " : ";
            for(Value* v : RG.getColorToValue(&F)[i]) {
                outs() << (v->hasName() ? v->getName() : "no-name") << " ";
            }
            outs() << "\n";
        }
        outs() << "\n";
        for(Value* v : RG.getValues(&F)) {
            for(auto w : RG.getAdjList(v)) {
                EXPECT_NE(RG.getValueToColor(&F, v), RG.getValueToColor(&F, w)) << "registers" << v->getName() << " " << w->getName() << " should not be the same color\n";
            }
        }
    }
}

int main(int argc, char **argv) {
  ::testing::InitGoogleTest(&argc, argv);
  return RUN_ALL_TESTS();
}