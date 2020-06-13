
#include "GEPUnpack.h"

#include "llvm/AsmParser/Parser.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/raw_os_ostream.h"

#include "gtest/gtest.h"

using namespace llvm;
using namespace std;
using namespace optim;

class GEPUnpackTest : public testing::Test{
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

TEST_F(GEPUnpackTest, Test1) {
    parseAssembly("test-ir/input1.ll");
    GEPUnpackPass pass;

    ModuleAnalysisManager MAM;
    pass.run(*M, MAM);

    for(Function& F : *M) {
        for(auto it = inst_begin(F); it!=inst_end(F); it++) {
            ASSERT_FALSE(isa<GetElementPtrInst>(&*it));
        }
    }

    M->print(outs(), nullptr);
}

TEST_F(GEPUnpackTest, Test2) {
    parseAssembly("test-ir/input2.ll");
    GEPUnpackPass pass;

    ModuleAnalysisManager MAM;
    pass.run(*M, MAM);

    for(Function& F : *M) {
        for(auto it = inst_begin(F); it!=inst_end(F); it++) {
            ASSERT_FALSE(isa<GetElementPtrInst>(&*it));
        }
    }

    M->print(outs(), nullptr);
}

TEST_F(GEPUnpackTest, Test3) {
    parseAssembly("test-ir/input3.ll");
    GEPUnpackPass pass;

    ModuleAnalysisManager MAM;
    pass.run(*M, MAM);

    for(Function& F : *M) {
        for(auto it = inst_begin(F); it!=inst_end(F); it++) {
            ASSERT_FALSE(isa<GetElementPtrInst>(&*it));
        }
    }

    M->print(outs(), nullptr);
}

TEST_F(GEPUnpackTest, Test4) {
    parseAssembly("test-ir/input4.ll");
    GEPUnpackPass pass;

    ModuleAnalysisManager MAM;
    pass.run(*M, MAM);

    for(Function& F : *M) {
        for(auto it = inst_begin(F); it!=inst_end(F); it++) {
            ASSERT_FALSE(isa<GetElementPtrInst>(&*it));
        }
    }

    M->print(outs(), nullptr);
}

int main(int argc, char **argv) {
  ::testing::InitGoogleTest(&argc, argv);
  return RUN_ALL_TESTS();
}