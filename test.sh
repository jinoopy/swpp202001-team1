#!/bin/bash

function test() {
	TESTNAME=$1
	echo "-----start test $1-----"
	if [[ "$OSTYPE" == "darwin"* ]]; then
		TIMEOUT="gtimeout 60"
	else
		TIMEOUT="timeout 60s"
	fi
	$TIMEOUT python3 compiler.py -run ~/swpp202001-test/$TESTNAME/src/$TESTNAME.ll \
	-o asmb/$TESTNAME.s
	for i in $(seq 1 5); do
		echo "----- case $i ------"
		echo "> Team 1 compiler"
		$TIMEOUT ~/swpp202001-interpreter/sf-interpreter asmb/$TESTNAME.s \
		< ~/swpp202001-test/$TESTNAME/test/input$i.txt > test/$TESTNAME-result$i.txt
		cmp ~/swpp202001-test/$TESTNAME/test/output$i.txt test/$TESTNAME-result$i.txt
		cat sf-interpreter.log
		echo "> swpp202001-compiler"
		~/swpp202001-interpreter/sf-interpreter ~/swpp202001-test/$TESTNAME/src/$TESTNAME.s \
		< ~/swpp202001-test/$TESTNAME/test/input$i.txt > /dev/null
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
	test "binary_tree"				#wrong answer
	test "bitcount1"
	test "bitcount2"
	test "bitcount3"
	test "bitcount4"
	test "bitcount5"
	test "bubble_sort" 		
	test "collatz"
	test "gcd"
	test "matmul1"
	test "matmul2"
	test "matmul3"					
	test "matmul4"
	test "prime"					#infinite loop
	test "rmq1d_naive"
	test "rmq1d_sparsetable"
	test "rmq2d_naive"
	test "rmq2d_sparsetable"		# memory error & wrong answer
									# but works if gv2malloc & inline both removed
	echo "----- end -----"
fi

