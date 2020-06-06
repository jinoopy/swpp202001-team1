#include "Backend.h"

#include "llvm/AsmParser/Parser.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/raw_os_ostream.h"

#include "gtest/gtest.h"

using namespace llvm;
using namespace std;
using namespace backend;

class BackendTest : public testing::Test
{

protected:
    LLVMContext Context;
    unique_ptr<Module> M;
    map<StringRef, Value*> nameToValue;
    Backend backend;

    BackendTest() : backend("-", true) {}

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

TEST_F(BackendTest, Test1) {
    parseAssembly("test-ir/input1.ll");
    
    RegisterGraph RG(*M);
    ModuleAnalysisManager MAM;

    backend.run(*M, MAM);
}

TEST_F(BackendTest, Test2) {
    parseAssembly("test-ir/input2.ll");
    
    RegisterGraph RG(*M);
    ModuleAnalysisManager MAM;

    backend.run(*M, MAM);
}

TEST_F(BackendTest, Test3) {
    parseAssembly("test-ir/input3.ll");
    
    RegisterGraph RG(*M);
    ModuleAnalysisManager MAM;

    backend.run(*M, MAM);
}

TEST_F(BackendTest, Test4) {
    parseAssembly("test-ir/input4.ll");
    
    RegisterGraph RG(*M);
    ModuleAnalysisManager MAM;

    backend.run(*M, MAM);
}

int main(int argc, char **argv) {
    outs() << "===============================\n";
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}