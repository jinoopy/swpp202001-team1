#!/bin/bash

function test() {
	TESTNAME=$1
	echo "-----start test $1-----"
	if [[ "$OSTYPE" == "darwin"* ]]; then
		TIMEOUT="gtimeout"
	else
		TIMEOUT="timeout"
	fi
	python3 compiler.py -run ~/swpp202001-test/$TESTNAME/src/$TESTNAME.ll \
	-o asmb/$TESTNAME.s
	for i in $(seq 1 5); do
		~/swpp202001-interpreter/sf-interpreter asmb/$TESTNAME.s \
		< ~/swpp202001-test/$TESTNAME/test/input$i.txt > test/$TESTNAME-result$i.txt
		cmp ~/swpp202001-test/$TESTNAME/test/output$i.txt test/$TESTNAME-result$i.txt
		cat sf-interpreter.log
	done
	echo "-----end test $TESTNAME-----"
}

if [[ "$1" == "build" || "$1" == "all" ]]; then
	echo "----- build -----"
	python3 compiler.py -build -bin ~/llvmscript/llvm-10.0-release/bin
fi

if [[ "$1" == "run" || "$1" == "all" ]]; then
	echo "----- run -----"
	if [[ "$#" -ne 1 ]]; then
		test $2
		exit 0
	fi
	test "binary_tree"			#wrong answer
	#test "bitcount1"
	#test "bitcount2"
	#test "bitcount3"
	#test "bitcount4"
	test "bitcount5"			#backend segfault
	test "bubble_sort" 			#runtime: address not aligned
	#test "collatz"
	#test "gcd"
	#test "matmul1"
	#test "matmul2"
	test "matmul3"				#wrong answer
	test "matmul4"				#compile timeout
	test "prime"				#infinite loop
	#test "rmq1d_naive"
	#test "rmq1d_sparsetable"
	test "rmq2d_naive"			#wrong answer
	test "rmq2d_sparsetable"	#malloc2gv: replaceUsesWithIf() type problem
	echo "----- end -----"
fi