#include "LivenessAnalysis.h"

#include "llvm/AsmParser/Parser.h"

#include "gtest/gtest.h"

class RegisterGraphTest : public testing::Test
{

protected:
    LLVMContext Context;
    unique_ptr<Module> M;
    map<StringRef, Instruction*> instrs;

    void parseAssembly(StringRef path) {
        SMDiagnostic Error;
        unique_ptr<Module> M = parseAssemblyFile(path, Error, Context);

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

    map<Instruction*, vector<bool>> getResult() {
        RegisterGraph RG(*M);
        return RG.live;
    }

};

#define t true
#define f false
#define V vector<bool>

TEST_F(RegisterGraphTest, LiveIntervalTest1) {
    parseAssembly("lapr1test/input1.ll");
    map<Instruction*, vector<bool>> rawResult = getResult();
    vector<vector<bool>> result;
    for(auto it = rawResult.begin(); it != rawResult.end(); ++it) {
        result.push_back(it->second);
    }

    vector<vector<bool>> ans;
    //              0, 1, 3, 5, 6, 7, 9, 11, 12, 13, 14, 15
//entry:
    ans.push_back(V{f, f, f, f, f, f, f,  f,  f,  f,  f,  f});
//2:
    ans.push_back(V{t, f, f, f, f, f, f,  f,  f,  f,  f,  f});
    ans.push_back(V{t, t, f, f, f, f, f,  f,  f,  f,  f,  f});
    ans.push_back(V{t, t, t, f, f, f, f,  f,  f,  f,  f,  f});
//4:
    ans.push_back(V{t, t, f, f, f, f, f,  f,  f,  f,  f,  f});
    ans.push_back(V{t, t, f, t, f, f, f,  f,  f,  f,  f,  f});
    ans.push_back(V{t, t, f, t, t, f, f,  f,  f,  f,  f,  f});
    ans.push_back(V{f, t, f, t, f, t, f,  f,  f,  f,  f,  f});
    ans.push_back(V{f, t, f, f, f, f, f,  f,  f,  f,  f,  f});
//8:
    ans.push_back(V{f, t, f, f, f, f, f,  f,  f,  f,  f,  f});
    ans.push_back(V{f, f, f, f, f, f, t,  f,  f,  f,  f,  f});
//10:
    ans.push_back(V{t, f, f, f, f, f, f,  f,  f,  f,  f,  f});
    ans.push_back(V{t, f, f, f, f, f, f,  t,  f,  f,  f,  f});
    ans.push_back(V{t, f, f, f, f, f, f,  f,  t,  f,  f,  f});
    ans.push_back(V{t, f, f, f, f, f, f,  f,  f,  t,  f,  f});
    ans.push_back(V{f, f, f, f, f, f, f,  f,  f,  f,  t,  f});
    ans.push_back(V{f, f, f, f, f, f, f,  f,  f,  f,  f,  t});

    EXPECT_EQ(result, ans);
}

int main(int argc, char **argv) {
  ::testing::InitGoogleTest(&argc, argv);
  return RUN_ALL_TESTS();
}