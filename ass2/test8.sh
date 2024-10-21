#!/usr/bin/env dash
echo "This is a test script for grip-branch"
echo "---------------------------------"


test1() {
	echo "Test 1 branch with no .grip:"
	touch a
	program_output=$(./grip-branch 2>stderr_a.log)
    program_stderr=$(cat stderr_a.log)
	rm -f a

	touch a
	expected_output=$(2041 grip-branch 2>stderr_e.log)
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
	echo "Test 2 branch with no commit:"
    touch a
    ./grip-init > /dev/null 2> /dev/null
    ./git-add a > /dev/null 2> /dev/null
    program_output=$(./grip-branch b1 2>stderr_a.log)
    program_stderr=$(cat stderr_a.log)
    rm -f a
    rm -rf .grip

    touch a
    2041 grip-init > /dev/null 2> /dev/null
    2041 git-add a > /dev/null 2> /dev/null
    expected_output=$(2041 grip-branch b1 2>stderr_e.log)
    expected_stderr=$(cat stderr_e.log)
    rm -f a
    rm -rf .grip

    if [ "$program_output" = "$expected_output" ] && [ "$program_stderr" = "$expected_stderr" ]; then
        echo "Passed"
        passed=$((passed+1))
    else
        echo "Failed"
        failed=$((failed+1))
    fi
}

test3() {
	echo "Test 3 branch list:"
    touch a
    ./grip-init > /dev/null 2> /dev/null
    ./git-add a > /dev/null 2> /dev/null
    ./grip-commit -m "commit 1" > /dev/null 2> /dev/null
    ./grip-branch b1 1> program_output.log 2> program_stderr.log
    ./grip-branch b2 1>> program_output.log 2>> program_stderr.log
    ./grip-branch b3 1>> program_output.log 2>> program_stderr.log
    ./grip-branch 1>> program_output.log 2>> program_stderr.log
    rm -f a
    rm -rf .grip

    touch a
    2041 grip-init > /dev/null 2> /dev/null
    2041 git-add a > /dev/null 2> /dev/null
    2041 grip-commit -m "commit 1" > /dev/null 2> /dev/null
    2041 grip-branch b1 1> expected_output.log 2> expected_stderr.log
    2041 grip-branch b2 1>> expected_output.log 2>> expected_stderr.log
    2041 grip-branch b3 1>> expected_output.log 2>> expected_stderr.log
    2041 grip-branch 1>> expected_output.log 2>> expected_stderr.log
    rm -f a
    rm -rf .grip

    if diff program_output.log expected_output.log > /dev/null && diff program_stderr.log expected_stderr.log > /dev/null; then
        echo "Passed"
        passed=$((passed+1))
    else
        echo "Failed"
        failed=$((failed+1))
    fi
	rm -f program_output.log program_stderr.log expected_output.log expected_stderr.log
}

test4() {
	echo "Test 4 branch create:"
    touch a
    ./grip-init > /dev/null 2> /dev/null
    ./git-add a > /dev/null 2> /dev/null
    ./grip-commit -m "commit 1" > /dev/null 2> /dev/null
    ./grip-branch b1 1> program_output.log 2> program_stderr.log
    ./grip-branch trunk 1>> program_output.log 2>> program_stderr.log
    ./grip-branch b1 1>> program_output.log 2>> program_stderr.log
    rm -f a
    rm -rf .grip

    touch a
    2041 grip-init > /dev/null 2> /dev/null
    2041 git-add a > /dev/null 2> /dev/null
    2041 grip-commit -m "commit 1" > /dev/null 2> /dev/null
    2041 grip-branch b1 1> expected_output.log 2> expected_stderr.log
    2041 grip-branch trunk 1>> expected_output.log 2>> expected_stderr.log
    2041 grip-branch b1 1>> expected_output.log 2>> expected_stderr.log
    rm -f a
    rm -rf .grip

    if diff program_output.log expected_output.log > /dev/null && diff program_stderr.log expected_stderr.log > /dev/null; then
        echo "Passed"
        passed=$((passed+1))
    else
        echo "Failed"
        failed=$((failed+1))
    fi

}

test5() {
	echo "Test 5 branch delete:"
    touch a
    ./grip-init > /dev/null 2> /dev/null
    ./git-add a > /dev/null 2> /dev/null
    ./grip-commit -m "commit 1" > /dev/null 2> /dev/null
    ./grip-branch b1 1> program_output.log 2> program_stderr.log
    ./grip-branch b2 1>> program_output.log 2>> program_stderr.log
    ./grip-branch b3 1>> program_output.log 2>> program_stderr.log
    ./grip-branch -d b2 1>> program_output.log 2>> program_stderr.log
    ./grip-branch -d b2 1>> program_output.log 2>> program_stderr.log
    ./grip-branch -d b4 1>> program_output.log 2>> program_stderr.log
    ./grip-branch -d trunk 1>> program_output.log 2>> program_stderr.log
    rm -f a
    rm -rf .grip

    touch a
    2041 grip-init > /dev/null 2> /dev/null
    2041 git-add a > /dev/null 2> /dev/null
    2041 grip-commit -m "commit 1" > /dev/null 2> /dev/null
    2041 grip-branch b1 1> expected_output.log 2> expected_stderr.log
    2041 grip-branch b2 1>> expected_output.log 2>> expected_stderr.log
    2041 grip-branch b3 1>> expected_output.log 2>> expected_stderr.log
    2041 grip-branch -d b2 1>> expected_output.log 2>> expected_stderr.log
    2041 grip-branch -d b2 1>> expected_output.log 2>> expected_stderr.log
    2041 grip-branch -d b4 1>> expected_output.log 2>> expected_stderr.log
    2041 grip-branch -d trunk 1>> expected_output.log 2>> expected_stderr.log
    rm -f a
    rm -rf .grip

    if diff program_output.log expected_output.log > /dev/null && diff program_stderr.log expected_stderr.log > /dev/null; then
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