#!/bin/bash

if [ "$#" -ne 3 ]; then
  echo "unreachable.sh build <input.ll> <clang dir>"
  echo "unreachable.sh run <input.ll> <clang dir>"
  echo "unreachable.sh all <input.ll> <clang dir>"
  echo "ex)  ./unreachable.sh all ~/my-llvm-release/bin"
  echo "ex2) ./unreachable.sh all ~/clang+llvm-9.0.0-x86_64-darwin-apple/bin"
  exit 1
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
  EXT=".dylib"
  ISYSROOT="-isysroot `xcrun --show-sdk-path`"
else
  EXT=".so"
  ISYSROOT=
fi

if [ "$1" != "run" ]; then
  LLVMCONFIG=$3/llvm-config
  CXXFLAGS=`$LLVMCONFIG --cxxflags`
  LDFLAGS=`$LLVMCONFIG --ldflags`
  LIBS=`$LLVMCONFIG --libs core irreader bitreader support --system-libs`

  CXX=$3/clang++
  CXXFLAGS="$CXXFLAGS -std=c++17"
  set -e

  $CXX $ISYSROOT $CXXFLAGS $LDFLAGS $LIBS LivenessAnalysis.cpp -o ./libLA$EXT -shared

fi

if [ "$1" != "build" ]; then
  set +e
  SCORE=0
  TOTAL=0

  echo "Tesing $2 ... "
  $3/opt -load-pass-plugin=./libLA$EXT -passes="liveness" -f "$2" 

fi
