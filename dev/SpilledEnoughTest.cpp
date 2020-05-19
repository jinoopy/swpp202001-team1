#include "RegisterSpill.h"
#include "LivenessAnalysis.h"

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
        if(F.isDeclaration()) continue;
        outs() << "===============================\n";
        outs() << F.getName() << "() coloration result\n";
        for(unsigned color = 0; color < RG.getNumColors(&F); color++) {
            outs() << "Color " << color << ":\n  ";
            for(Value* V : RG.getColorToValue(&F)[color]) {
                outs() << V->getName() << " ";
            }
            stringstream ss;
            ss << fixed << setprecision(2) << result[&F][color];
            outs() << "\n  Spill cost: " << ss.str() << "\n";
        }
    }

    RegisterSpillPass().run(*M, MAM);
    
    outs() << "===============================\n";
}

TEST_F(SpillCostTest, SpillCostTest2) {
    parseAssembly("test-ir/input2.ll");
    
    RegisterGraph RG(*M);
    ModuleAnalysisManager MAM;

    auto result = SpillCostAnalysis().run(*M, MAM);

    for(Function& F : *M) {
        if(F.isDeclaration()) continue;
        outs() << "===============================\n";
        outs() << F.getName() << "() coloration result\n";
        for(unsigned color = 0; color < RG.getNumColors(&F); color++) {
            outs() << "Color " << color << ":\n  ";
            for(Value* V : RG.getColorToValue(&F)[color]) {
                outs() << V->getName() << " ";
            }
            stringstream ss;
            ss << fixed << setprecision(2) << result[&F][color];
            outs() << "\n  Spill cost: " << ss.str() << "\n";
        }
    }

    RegisterSpillPass().run(*M, MAM);
    
    outs() << "===============================\n";
}

TEST_F(SpillCostTest, SpillCostTest3) {
    parseAssembly("test-ir/input3.ll");
    
    RegisterGraph RG(*M);
    ModuleAnalysisManager MAM;

    auto result = SpillCostAnalysis().run(*M, MAM);

    for(Function& F : *M) {
        if(F.isDeclaration()) continue;
        outs() << "===============================\n";
        outs() << F.getName() << "() coloration result\n";
        for(unsigned color = 0; color < RG.getNumColors(&F); color++) {
            outs() << "Color " << color << ":\n  ";
            for(Value* V : RG.getColorToValue(&F)[color]) {
                outs() << V->getName() << " ";
            }
            stringstream ss;
            ss << fixed << setprecision(2) << result[&F][color];
            outs() << "\n  Spill cost: " << ss.str() << "\n";
        }
    }

    RegisterSpillPass().run(*M, MAM);
    
    outs() << "===============================\n";
}


int main(int argc, char **argv) {
    outs() << "===============================\n";
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}