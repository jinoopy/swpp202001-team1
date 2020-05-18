clang -o src/LoopOptimPipe1.so src/LoopOptimPipe1.cpp

#clang -S -emit-llvm -o src/test-ir/input1.ll src/test-ir/input1.cpp
#clang -S -emit-llvm -o src/test-ir/input2.ll src/test-ir/input2.cpp
#clang -S -emit-llvm -o src/test-ir/input3.ll src/test-ir/input3.cpp
#clang -S -emit-llvm -o src/test-ir/input4.ll src/test-ir/input4.cpp

~/llvmscript/llvm-10.0-releaseassert/bin/opt -S -loop-simplify -lcssa -licm -loop-rotate -loop-unswitch -o src/test-ir/desired1.ll src/test-ir/input1.ll
~/llvmscript/llvm-10.0-releaseassert/bin/opt -S -loop-simplify -lcssa -licm -loop-rotate -loop-unswitch -o src/test-ir/desired2.ll src/test-ir/input2.ll
~/llvmscript/llvm-10.0-releaseassert/bin/opt -S -loop-simplify -lcssa -licm -loop-rotate -loop-unswitch -o src/test-ir/desired3.ll src/test-ir/input3.ll
~/llvmscript/llvm-10.0-releaseassert/bin/opt -S -loop-simplify -lcssa -licm -loop-rotate -loop-unswitch -o src/test-ir/desired4.ll src/test-ir/input4.ll

~/llvmscript/llvm-10.0-releaseassert/bin/opt -S -load src/LoopOptimPipe1.so -o src/test-ir/output1.ll src/test-ir/input1.ll
~/llvmscript/llvm-10.0-releaseassert/bin/opt -S -load src/LoopOptimPipe1.so -o src/test-ir/output2.ll src/test-ir/input2.ll
~/llvmscript/llvm-10.0-releaseassert/bin/opt -S -load src/LoopOptimPipe1.so -o src/test-ir/output3.ll src/test-ir/input3.ll
~/llvmscript/llvm-10.0-releaseassert/bin/opt -S -load src/LoopOptimPipe1.so -o src/test-ir/output4.ll src/test-ir/input4.ll