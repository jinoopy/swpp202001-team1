#include "Backend.h"

#include "llvm/AsmParser/Parser.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/raw_os_ostream.h"

#include <string>

using namespace std;
using namespace llvm;

int main(int argc, char *argv[]) {
  //Parse command line arguments
  if(argc!=3) return -1;
  string optInput = argv[1];
  string optOutput = argv[2];
  bool optPrintProgress = true;

  //Parse input LLVM IR module
  LLVMContext Context;
  unique_ptr<Module> M;

  SMDiagnostic Error;
  M = parseAssemblyFile(optInput, Error, Context);

  //If loading file failed:
  string errMsg;
  raw_string_ostream os(errMsg);
  Error.print("", os);

  if (!M)
    return 1;

  //Run the backend
  ModuleAnalysisManager MAM;

  Backend B(optOutput, optPrintProgress);

  B.run(*M, MAM);
  
  return 0;
}