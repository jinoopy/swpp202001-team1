#include "GvToMalloc.h"

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

    vector<vector<bool>> getResult() {
        RegisterGraph RG(*M);
        return RG.live_values;
    }

};

#define t true
#define f false
#define V vector<bool>

TEST_F(RegisterGraphTest, LiveIntervalTest1) {
    parseAssembly("lapr1test/input1.ll");
    vector<vector<bool>> result = getResult();

    vector<vector<bool>> ans;
    //              0, 1, 3, 5, 6, 7, 9, 11, 12, 13, 14, 15
//entry:
    ans.push_back(V{f, f, f, f, f, f, f,  f,  f,  f,  f,  f});//0
    ans.push_back(V{t, f, f, f, f, f, f,  f,  f,  f,  f,  f});//1
//BB1:
    ans.push_back(V{t, f, f, f, f, f, f,  f,  f,  f,  f,  f});//2
    ans.push_back(V{t, t, f, f, f, f, f,  f,  f,  f,  f,  f});//3
    ans.push_back(V{t, t, t, f, f, f, f,  f,  f,  f,  f,  f});//4
//BB2:
    ans.push_back(V{t, t, f, f, f, f, f,  f,  f,  f,  f,  f});//5
    ans.push_back(V{t, t, f, t, f, f, f,  f,  f,  f,  f,  f});//6
    ans.push_back(V{t, t, f, t, t, f, f,  f,  f,  f,  f,  f});//7
    ans.push_back(V{f, t, f, t, f, t, f,  f,  f,  f,  f,  f});//8
    ans.push_back(V{f, t, f, f, f, f, f,  f,  f,  f,  f,  f});//9
//BB3:
    ans.push_back(V{f, t, f, f, f, f, f,  f,  f,  f,  f,  f});//10
    ans.push_back(V{f, f, f, f, f, f, t,  f,  f,  f,  f,  f});//11
//BB4:
    ans.push_back(V{t, f, f, f, f, f, f,  f,  f,  f,  f,  f});//12
    ans.push_back(V{t, f, f, f, f, f, f,  t,  f,  f,  f,  f});//13
    ans.push_back(V{t, f, f, f, f, f, f,  f,  t,  f,  f,  f});//14
    ans.push_back(V{t, f, f, f, f, f, f,  f,  f,  t,  f,  f});//15
    ans.push_back(V{f, f, f, f, f, f, f,  f,  f,  f,  t,  f});//16
    ans.push_back(V{f, f, f, f, f, f, f,  f,  f,  f,  f,  t});//17

    ASSERT_EQ(result.size(), ans.size());
    for(int i = 0; i < result.size(); i++) {
        EXPECT_EQ(result[i], ans[i]) <<"result["<<i<<"] mismatch\n";
    }
}

TEST_F(RegisterGraphTest, LiveIntervalTest2) {
    parseAssembly("lapr1test/input2.ll");
    vector<vector<bool>> result = getResult();

    vector<vector<bool>> ans;
    //              0, 1, 2, 3, 4, 5, 6, 7, 8, 9
//entry:
    ans.push_back(V{f, f, f, f, f, f, f, f, f, f});//0
//BB1:
    ans.push_back(V{f, f, f, f, f, f, f, f, f, f});//1
    ans.push_back(V{t, f, f, f, f, f, f, f, f, f});//2
    ans.push_back(V{t, t, f, f, f, f, f, f, f, f});//3
    ans.push_back(V{t, t, t, f, f, f, f, f, f, f});//4
//BB2:
    ans.push_back(V{t, f, f, f, f, f, f, f, f, f});//5
    ans.push_back(V{t, f, f, t, f, f, f, f, f, f});//6
    ans.push_back(V{t, f, f, f, t, f, f, f, f, f});//7
//BB3:
    ans.push_back(V{t, f, f, f, f, f, f, f, f, f});//8
    ans.push_back(V{f, f, f, f, f, t, f, f, f, f});//9
//BB4:
    ans.push_back(V{t, f, f, f, f, f, f, f, f, f});//10
    ans.push_back(V{f, f, f, f, f, f, t, f, f, f});//11
    ans.push_back(V{f, f, f, f, f, f, f, t, f, f});//12
//BB5:
    ans.push_back(V{f, t, f, f, f, f, f, f, f, f});//13
    ans.push_back(V{f, t, f, f, f, f, f, f, t, f});//14
    ans.push_back(V{f, f, f, f, f, f, f, f, t, t});//15
//BB6:
    ans.push_back(V{f, t, f, f, f, f, f, f, f, f});//16

    ASSERT_EQ(result.size(), ans.size());
    for(int i = 0; i < result.size(); i++) {
        EXPECT_EQ(result[i], ans[i]) <<"result["<<i<<"] mismatch\n";
    }
}

int main(int argc, char **argv) {
  ::testing::InitGoogleTest(&argc, argv);
  return RUN_ALL_TESTS();
}