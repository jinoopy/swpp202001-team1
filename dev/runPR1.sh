#!/bin/bash

if [ "$#" -ne 2 ]; then
  echo "run.sh build <clang dir>"
  echo "run.sh run <clang dir>"
  echo "run.sh all <clang dir>"
  echo "ex)  ./run.sh all ~/llvm-10.0-releaseassert/bin"
  exit 1
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
  ISYSROOT="-isysroot `xcrun --show-sdk-path`"
else
  ISYSROOT=
fi

if [[ "$1" == "build" || "$1" == "all" ]]; then
  echo "----- build -----"
  LLVMCONFIG=$2/llvm-config
  CXXFLAGS=`$LLVMCONFIG --cxxflags`
  LDFLAGS=`$LLVMCONFIG --ldflags`
  LDFLAGS="$LDFLAGS -Wl,-rpath,`$LLVMCONFIG --libdir`"
  LIBS=`$LLVMCONFIG --libs core irreader bitreader passes support analysis asmparser --system-libs`
  SRCROOT=`$LLVMCONFIG --src-root`

  CXX=$2/clang++
  CXXFLAGS="$CXXFLAGS -std=c++17 -I${SRCROOT}/include"
  CXXFLAGS="$CXXFLAGS -I${SRCROOT}/utils/unittest/googletest/include"
  CXXFLAGS="$CXXFLAGS -I${SRCROOT}/utils/unittest/googletest/"
  CXXFLAGS="$CXXFLAGS -I../src/backend"
  CXXFLAGS="$CXXFLAGS -I."
  set -e

  $CXX $ISYSROOT $CXXFLAGS $LDFLAGS -frtti $LIBS Backend.cpp TargetMachine.cpp BackendPR1Test.cpp AssemblyEmitter.cpp ../src/backend/LivenessAnalysis.cpp -lpthread -lm \
       $SRCROOT/utils/unittest/googletest/src/gtest-all.cc \
       -o runPR1
fi

if [[ "$1" == "run" || "$1" == "all" ]]; then
  echo "----- run -----"
  set +e
  ./runPR1
fi