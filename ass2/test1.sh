#!/usr/bin/env dash
echo "This is a test script for grip-add"
echo "---------------------------------"

test1() {
	echo "Test 1 add with no .grip:"
	touch a
	program_output=$(./grip-add a 2>stderr_a.log)
    program_stderr=$(cat stderr_a.log)
	rm a

	touch a
	expected_output=$(2041 grip-add a 2>stderr_e.log)
    expected_stderr=$(cat stderr_e.log)
	rm a

    if [ "$program_output" = "$expected_output" ] && [ "$program_stderr" = "$expected_stderr" ]; then
        echo "Passed"
        passed=$((passed+1))
    else
        echo "Failed"
        failed=$((failed+1))
    fi
}

test2() {
	echo "Test 2 add with file does not exist:"
	program_output=$(./grip-add a 2>stderr_a.log)
    program_stderr=$(cat stderr_a.log)

	expected_output=$(2041 grip-add a 2>stderr_e.log)
    expected_stderr=$(cat stderr_e.log)

    if [ "$program_output" = "$expected_output" ] && [ "$program_stderr" = "$expected_stderr" ]; then
        echo "Passed"
        passed=$((passed+1))
    else
        echo "Failed"
        failed=$((failed+1))
    fi
}

test3() {
	echo "Test 3 add a single file:"
	touch a
	./grip-init 1> /dev/null 2> /dev/null
	program_output=$(./grip-add a 2>stderr_a.log)
    program_stderr=$(cat stderr_a.log)
	rm a
	rm -rf .grip

	touch a
	2041 grip-init 1> /dev/null 2> /dev/null
	expected_output=$(2041 grip-add a 2>stderr_e.log)
    expected_stderr=$(cat stderr_e.log)
	rm a
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
	echo "Test 4 add no file:"
	./grip-init 1> /dev/null 2> /dev/null
	program_output=$(./grip-add 2>stderr_a.log)
    program_stderr=$(cat stderr_a.log)
	rm -rf .grip

	2041 grip-init 1> /dev/null 2> /dev/null
	expected_output=$(2041 grip-add 2>stderr_e.log)
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

test5() {
	echo "Test 5 add multiple files:"
	touch a b c
	./grip-init 1> /dev/null 2> /dev/null
	program_output=$(./grip-add a b c 2>stderr_a.log)
    program_stderr=$(cat stderr_a.log)
	rm a b c
	rm -rf .grip

	touch a b c
	2041 grip-init 1> /dev/null 2> /dev/null
	expected_output=$(2041 grip-add a b c 2>stderr_e.log)
    expected_stderr=$(cat stderr_e.log)
	rm a b c
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