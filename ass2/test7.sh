#!/usr/bin/env dash
echo "This is a test script for grip-status"
echo "---------------------------------"

test1() {
	echo "Test 1 status with no .grip:"
	touch a
	program_output=$(./grip-status 2>stderr_a.log)
    program_stderr=$(cat stderr_a.log)
	rm -f a

	touch a
	expected_output=$(2041 grip-status 2>stderr_e.log)
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
    echo "Test 2 status all untracked files:"
    ./grip-init > /dev/null 2>/dev/null
    program_output=$(./grip-status 2>stderr_a.log)
    program_stderr=$(cat stderr_a.log)
    rm -rf .grip

    2041 grip-init > /dev/null 2>/dev/null
    expected_output=$(2041 grip-status 2>stderr_e.log)
    expected_stderr=$(cat stderr_e.log)
    rm -rf .grip

    if [ "$program_output" = "$expected_output" ] && [ "$program_stderr" = "$expected_stderr" ]; then
        echo "Passed"
        passed=$((passed+1))
    else
        echo "Failed"
        failed=$((failed+1))
    fi
    rm -f stderr_a.log stderr_e.log
}

test3() {
    echo "Test 3 status changes staged for commit:"
    touch a
    ./grip-init > /dev/null 2>/dev/null
    ./grip-add a > /dev/null 2>/dev/null
    ./grip-commit -m "Initial commit" > /dev/null 2>/dev/null
    echo "Hello" > a
    ./grip-add a > /dev/null 2>/dev/null
    ./grip-status > program_output.log 2>program_stderr.log
    rm -f a
    rm -rf .grip

    touch a
    2041 grip-init > /dev/null 2>/dev/null
    2041 grip-add a > /dev/null 2>/dev/null
    2041 grip-commit -m "Initial commit" > /dev/null 2>/dev/null
    echo "Hello" > a
    2041 grip-add a > /dev/null 2>/dev/null
    2041 grip-status > expected_output.log 2>expected_stderr.log
    rm -f a
    rm -rf .grip

    if diff program_output.log expected_output.log > /dev/null && diff expected_stderr.log program_stderr.log > /dev/null; then
        echo "Passed"
        passed=$((passed+1))
    else
        echo "Failed"
        failed=$((failed+1))
    fi
}

test4() {
    echo "Test 4 status same as repo:"
    touch a
    ./grip-init > /dev/null 2>/dev/null
    ./grip-add a > /dev/null 2>/dev/null
    ./grip-commit -m "Initial commit" > /dev/null 2>/dev/null
    ./grip-status > program_output.log 2>program_stderr.log
    rm -f a
    rm -rf .grip

    touch a
    2041 grip-init > /dev/null 2>/dev/null
    2041 grip-add a > /dev/null 2>/dev/null
    2041 grip-commit -m "Initial commit" > /dev/null 2>/dev/null
    2041 grip-status > expected_output.log 2>expected_stderr.log
    rm -f a
    rm -rf .grip

    if diff program_output.log expected_output.log > /dev/null && diff expected_stderr.log program_stderr.log > /dev/null; then
        echo "Passed"
        passed=$((passed+1))
    else
        echo "Failed"
        failed=$((failed+1))
    fi
}

test5() {
    echo "Test 5 status deleted from index:"
    touch a
    ./grip-init > /dev/null 2>/dev/null
    ./grip-add a > /dev/null 2>/dev/null
    ./grip-commit -m "Initial commit" > /dev/null 2>/dev/null
    ./grip-rm --cached a > /dev/null 2>/dev/null
    ./grip-status > program_output.log 2>program_stderr.log
    rm -f a
    rm -rf .grip

    touch a
    2041 grip-init > /dev/null 2>/dev/null
    2041 grip-add a > /dev/null 2>/dev/null
    2041 grip-commit -m "Initial commit" > /dev/null 2>/dev/null
    2041 grip-rm --cached a > /dev/null 2>/dev/null
    2041 grip-status > expected_output.log 2>expected_stderr.log
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

test6() {
    echo "Test 6 status added to index:"
    touch a
    ./grip-init > /dev/null 2>/dev/null
    ./grip-add a > /dev/null 2>/dev/null
    ./grip-status > program_output.log 2>program_stderr.log
    rm -f a
    rm -rf .grip

    touch a
    2041 grip-init > /dev/null 2>/dev/null
    2041 grip-add a > /dev/null 2>/dev/null
    2041 grip-status > expected_output.log 2>expected_stderr.log
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
num_tests=6
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
echo "** $passed tests passed, $failed tests failed - mark: $passed/$num_tests"