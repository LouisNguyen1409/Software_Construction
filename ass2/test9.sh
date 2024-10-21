#!/usr/bin/env dash
echo "This is a test script for grip-checkout"
echo "---------------------------------"

test1() {
	echo "Test 1 checkout with no .grip:"
	touch a
	program_output=$(./grip-checkout b1 2>stderr_a.log)
    program_stderr=$(cat stderr_a.log)
	rm -f a

	touch a
	expected_output=$(2041 grip-checkout b1 2>stderr_e.log)
    expected_stderr=$(cat stderr_e.log)
	rm -f a

    if [ "$program_output" = "$expected_output" ] && [ "$program_stderr" = "$expected_stderr" ]; then
        echo "Passed"
        passed=$((passed+1))
    else
        echo "Failed"
        failed=$((failed+1))
    fi
}

test2() {
	echo "Test 2 checkout with not enough params:"
    touch a
    ./grip-init 1> program_output.log 2> program_stderr.log
    ./grip-add a 1> program_output.log 2> program_stderr.log
    ./grip-commit -m "commit 1" 1> program_output.log 2> program_stderr.log
    ./grip-branch b1 1> program_output.log 2> program_stderr.log
    ./grip-checkout 1> program_output.log 2> program_stderr.log
    rm -f a
    rm -rf .grip

    touch a
    2041 grip-init 1> expected_output.log 2> expected_stderr.log
    2041 grip-add a 1> expected_output.log 2> expected_stderr.log
    2041 grip-commit -m "commit 1" 1> expected_output.log 2> expected_stderr.log
    2041 grip-branch b1 1> expected_output.log 2> expected_stderr.log
    2041 grip-checkout 1> expected_output.log 2> expected_stderr.log
    rm -f a
    rm -rf .grip

    if diff program_stderr.log expected_stderr.log && diff program_output.log expected_output.log; then
        echo "Passed"
        passed=$((passed+1))
    else
        echo "Failed"
        failed=$((failed+1))
    fi

}

test3() {
    echo "Test 3 checkout with unknown branch:"
    touch a
    ./grip-init 1> program_output.log 2> program_stderr.log
    ./grip-add a 1> program_output.log 2> program_stderr.log
    ./grip-commit -m "commit 1" 1> program_output.log 2> program_stderr.log
    ./grip-branch b1 1> program_output.log 2> program_stderr.log
    ./grip-checkout b2 1> program_output.log 2> program_stderr.log
    rm -f a
    rm -rf .grip

    touch a
    2041 grip-init 1> expected_output.log 2> expected_stderr.log
    2041 grip-add a 1> expected_output.log 2> expected_stderr.log
    2041 grip-commit -m "commit 1" 1> expected_output.log 2> expected_stderr.log
    2041 grip-branch b1 1> expected_output.log 2> expected_stderr.log
    2041 grip-checkout b2 1> expected_output.log 2> expected_stderr.log
    rm -f a
    rm -rf .grip

    if diff program_stderr.log expected_stderr.log && diff program_output.log expected_output.log; then
        echo "Passed"
        passed=$((passed+1))
    else
        echo "Failed"
        failed=$((failed+1))
    fi
    rm -f program_stderr.log program_output.log expected_stderr.log expected_output.log
}

test4() {
	echo "Test 4 checkout with add commit checkout:"
    mkdir testing
    cd testing
    touch a
    echo "hello" > a
    ../grip-init 1> ../program_output.log 2> ../program_stderr.log
    ../grip-add a 1>> ../program_output.log 2>> ../program_stderr.log
    ../grip-commit -m "commit 1" 1>> ../program_output.log 2>> ../program_stderr.log
    ../grip-branch b1 1>> ../program_output.log 2>> ../program_stderr.log
    ../grip-checkout b1 1>> ../program_output.log 2>> ../program_stderr.log
    touch b
    echo "hello" > b
    ../grip-add b 1>> ../program_output.log 2>> ../program_stderr.log
    ../grip-commit -m "commit 2" 1>> ../program_output.log 2>> ../program_stderr.log
    ../grip-checkout trunk 1>> ../program_output.log 2>> ../program_stderr.log
    rm -f a b
    cd ..
    rm -rf .grip testing

    mkdir testing
    cd testing
    touch a
    echo "hello" > a
    2041 grip-init 1> ../expected_output.log 2> ../expected_stderr.log
    2041 grip-add a 1>> ../expected_output.log 2>> ../expected_stderr.log
    2041 grip-commit -m "commit 1" 1>> ../expected_output.log 2>> ../expected_stderr.log
    2041 grip-branch b1 1>> ../expected_output.log 2>> ../expected_stderr.log
    2041 grip-checkout b1 1>> ../expected_output.log 2>> ../expected_stderr.log
    touch b
    echo "hello" > b
    2041 grip-add b 1>> ../expected_output.log 2>> ../expected_stderr.log
    2041 grip-commit -m "commit 2" 1>> ../expected_output.log 2>> ../expected_stderr.log
    2041 grip-checkout trunk 1>> ../expected_output.log 2>> ../expected_stderr.log
    rm -f a b
    cd ..
    rm -rf .grip testing

    if diff program_stderr.log expected_stderr.log && diff program_output.log expected_output.log; then
        echo "Passed"
        passed=$((passed+1))
    else
        echo "Failed"
        failed=$((failed+1))
    fi
}

test5() {
	echo "Test 5 checkout with error:"
    mkdir testing
    cd testing
    ../grip-init 1> ../program_output.log 2> ../program_stderr.log
    echo hello >a
    ../grip-add a 1>> ../program_output.log 2>> ../program_stderr.log
    ../grip-commit -m "commit 1" 1>> ../program_output.log 2>> ../program_stderr.log
    ../grip-branch b1 1>> ../program_output.log 2>> ../program_stderr.log
    echo world >b
    ../grip-add b 1>> ../program_output.log 2>> ../program_stderr.log
    ../grip-commit -m "commit 2" 1>> ../program_output.log 2>> ../program_stderr.log
    ../grip-checkout b1 1>> ../program_output.log 2>> ../program_stderr.log
    echo new contents >b
    ../grip-checkout trunk 1>> ../program_output.log 2>> ../program_stderr.log
    rm -f a b
    cd ..
    rm -rf .grip testing

    mkdir testing
    cd testing
    2041 grip-init 1> ../expected_output.log 2> ../expected_stderr.log
    echo hello >a
    2041 grip-add a 1>> ../expected_output.log 2>> ../expected_stderr.log
    2041 grip-commit -m "commit 1" 1>> ../expected_output.log 2>> ../expected_stderr.log
    2041 grip-branch b1 1>> ../expected_output.log 2>> ../expected_stderr.log
    echo world >b
    2041 grip-add b 1>> ../expected_output.log 2>> ../expected_stderr.log
    2041 grip-commit -m "commit 2" 1>> ../expected_output.log 2>> ../expected_stderr.log
    2041 grip-checkout b1 1>> ../expected_output.log 2>> ../expected_stderr.log
    echo new contents >b
    2041 grip-checkout trunk 1>> ../expected_output.log 2>> ../expected_stderr.log
    rm -f a b
    cd ..
    rm -rf .grip testing

    if diff program_stderr.log expected_stderr.log && diff program_output.log expected_output.log; then
        echo "Passed"
        passed=$((passed+1))
    else
        echo "Failed"
        failed=$((failed+1))
    fi

}

i=1
num_tests=5
passed=0
failed=0
while [ $i -le $num_tests ]; do
    rm -rf .grip
    test_name="test$i"
    # Check if the function is defined and call it
    if command -v "$test_name" > /dev/null 2>&1; then
        "$test_name"
    else
        echo "Function $test_name not defined"
    fi
    i=$((i + 1))
    echo "---------------------------------"
    rm -rf .grip
done
rm -f stderr_a.log stderr_e.log
echo "** $passed tests passed, $failed tests failed - mark: $passed/$num_tests"