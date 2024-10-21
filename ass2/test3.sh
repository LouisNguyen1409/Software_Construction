#!/usr/bin/env dash
echo "This is a test script for grip-log"
echo "---------------------------------"

test1() {
	echo "Test 1 log with no .grip:"
	program_output=$(./grip-log 2>stderr_a.log)
    program_stderr=$(cat stderr_a.log)

	expected_output=$(2041 grip-log 2>stderr_e.log)
    expected_stderr=$(cat stderr_e.log)

    if [ "$program_output" = "$expected_output" ] && [ "$program_stderr" = "$expected_stderr" ]; then
        echo "Passed"
        passed=$((passed+1))
    else
        echo "Failed"
        failed=$((failed+1))
    fi
}

test2() {
	echo "Test 2 log with no commit:"
	./grip-init 1> /dev/null 2> /dev/null
	program_output=$(./grip-log 2>stderr_a.log)
    program_stderr=$(cat stderr_a.log)
	rm -rf .grip

	2041 grip-init 1> /dev/null 2> /dev/null
	expected_output=$(2041 grip-log 2>stderr_e.log)
    expected_stderr=$(cat stderr_e.log)
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
	echo "Test 3 log with 1 commit:"
	touch a
	./grip-init 1> /dev/null 2> /dev/null
	./grip-add a 1> /dev/null 2> /dev/null
	./grip-commit -m "commit 1" 1> /dev/null 2> /dev/null
	program_output=$(./grip-log 2>stderr_a.log)
    program_stderr=$(cat stderr_a.log)
	rm -f a
	rm -rf .grip

	touch a
	2041 grip-init 1> /dev/null 2> /dev/null
	2041 grip-add a 1> /dev/null 2> /dev/null
	2041 grip-commit -m "commit 1" 1> /dev/null 2> /dev/null
	expected_output=$(2041 grip-log 2>stderr_e.log)
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

test4() {
	echo "Test 4 log with multiple commits:"
	touch a b c
	./grip-init 1> /dev/null 2> /dev/null
	./grip-add a 1> /dev/null 2> /dev/null
	./grip-commit -m "commit 1" 1> /dev/null 2> /dev/null
	./grip-add b 1> /dev/null 2> /dev/null
	./grip-commit -m "commit 2" 1> /dev/null 2> /dev/null
	./grip-add c 1> /dev/null 2> /dev/null
	./grip-commit -m "commit 3" 1> /dev/null 2> /dev/null
	program_output=$(./grip-log 2>stderr_a.log)
    program_stderr=$(cat stderr_a.log)
	rm -f a b c
	rm -rf .grip

	touch a b c
	2041 grip-init 1> /dev/null 2> /dev/null
	2041 grip-add a 1> /dev/null 2> /dev/null
	2041 grip-commit -m "commit 1" 1> /dev/null 2> /dev/null
	2041 grip-add b 1> /dev/null 2> /dev/null
	2041 grip-commit -m "commit 2" 1> /dev/null 2> /dev/null
	2041 grip-add c 1> /dev/null 2> /dev/null
	2041 grip-commit -m "commit 3" 1> /dev/null 2> /dev/null
	expected_output=$(2041 grip-log 2>stderr_e.log)
    expected_stderr=$(cat stderr_e.log)
	rm -f a b c
	rm -rf .grip

    if [ "$program_output" = "$expected_output" ] && [ "$program_stderr" = "$expected_stderr" ]; then
        echo "Passed"
        passed=$((passed+1))
    else
        echo "Failed"
        failed=$((failed+1))
    fi
}

i=1
num_tests=4
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