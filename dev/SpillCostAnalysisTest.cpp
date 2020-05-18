#include "RegisterSpill.h"

#include "llvm/AsmParser/Parser.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/raw_os_ostream.h"

#include "gtest/gtest.h"

using namespace llvm;
using namespace std;
using namespace backend;

class SpillCostTest : public testing::Test
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

TEST_F(SpillCostTest, SpillCostTest1) {
    parseAssembly("test-ir/input1.ll");
    
    RegisterGraph RG(*M);
    ModuleAnalysisManager MAM;

    auto result = SpillCostAnalysis().run(*M, MAM);

    for(Function& F : *M) {
        outs() << F.getName() << " coloration result\n";
        for(unsigned color = 0; color < RG.getNumColors(&F); color++) {
            outs() << color << ":\n  ";
            for(Value* V : RG.getColorToValue(&F)[color]) {
                outs() << V->getName() << " ";
            }
            outs() << "\n";
            outs() << result[&F][color];
        }
    }
}