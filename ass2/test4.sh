#!/usr/bin/env dash
echo "This is a test script for grip-show"
echo "---------------------------------"

test1() {
	echo "Test 1 show with no .grip:"
	program_output=$(./grip-show :a 2>stderr_a.log)
    program_stderr=$(cat stderr_a.log)

	expected_output=$(2041 grip-show :a 2>stderr_e.log)
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
	echo "Test 2 show with no params:"
	./grip-init 1> /dev/null 2> /dev/null
	echo 1 > a
	./grip-add a 1> /dev/null 2> /dev/null
	echo 2 > a
	./grip-commit -m message 1> /dev/null 2> /dev/null
	echo 3 > a
	program_output=$(./grip-show 2>stderr_a.log)
    program_stderr=$(cat stderr_a.log)
	rm -f a
	rm -rf .grip

	2041 grip-init 1> /dev/null 2> /dev/null
	echo 1 > a
	2041 grip-add a 1> /dev/null 2> /dev/null
	echo 2 > a
	2041 grip-commit -m message 1> /dev/null 2> /dev/null
	echo 3 > a
	expected_output=$(2041 grip-show 2>stderr_e.log)
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
	echo "Test 3 log with 1 commit and got commit param:"
	./grip-init 1> /dev/null 2> /dev/null
	echo 1 > a
	./grip-add a 1> /dev/null 2> /dev/null
	echo 2 > a
	./grip-commit -m message 1> /dev/null 2> /dev/null
	echo 3 > a
	program_output=$(./grip-show 0:a 2>stderr_a.log)
    program_stderr=$(cat stderr_a.log)
	rm -f a
	rm -rf .grip

	2041 grip-init 1> /dev/null 2> /dev/null
	echo 1 > a
	2041 grip-add a 1> /dev/null 2> /dev/null
	echo 2 > a
	2041 grip-commit -m message 1> /dev/null 2> /dev/null
	echo 3 > a
	expected_output=$(2041 grip-show 0:a 2>stderr_e.log)
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
	echo "Test 4 log with 1 commit and no commit param:"
	./grip-init 1> /dev/null 2> /dev/null
	echo 1 > a
	./grip-add a 1> /dev/null 2> /dev/null
	echo 2 > a
	./grip-commit -m message 1> /dev/null 2> /dev/null
	echo 3 > a
	program_output=$(./grip-show :a 2>stderr_a.log)
    program_stderr=$(cat stderr_a.log)
	rm -f a
	rm -rf .grip

	2041 grip-init 1> /dev/null 2> /dev/null
	echo 1 > a
	2041 grip-add a 1> /dev/null 2> /dev/null
	echo 2 > a
	2041 grip-commit -m message 1> /dev/null 2> /dev/null
	echo 3 > a
	expected_output=$(2041 grip-show :a 2>stderr_e.log)
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

test5() {
	echo "Test 5 log with multiple commit:"
	./grip-init 1> /dev/null 2> /dev/null
	echo line 1 > a
	echo hello world > b
	./grip-add a b 1> /dev/null 2> /dev/null
	./grip-commit -m "first commit" 1> /dev/null 2> /dev/null
	echo line 2 >> a
	./grip-add a 1> /dev/null 2> /dev/null
	./grip-commit -m "second commit" 1> /dev/null 2> /dev/null
	echo line 3 >> a
	./grip-add a 1> /dev/null 2> /dev/null
	echo line 4 >> a
	./grip-show 0:a 1> program_output.log 2> program_stderr.log
	./grip-show 1:a 1>> program_output.log 2>> program_stderr.log
	./grip-show :a 1>> program_output.log 2>> program_stderr.log
	./grip-show 0:b 1>> program_output.log 2>> program_stderr.log
	./grip-show 1:b 1>> program_output.log 2>> program_stderr.log
	rm -f a b
	rm -rf .grip

	2041 grip-init 1> /dev/null 2> /dev/null
	echo line 1 > a
	echo hello world > b
	2041 grip-add a b 1> /dev/null 2> /dev/null
	2041 grip-commit -m "first commit" 1> /dev/null 2> /dev/null
	echo line 2 >> a
	2041 grip-add a 1> /dev/null 2> /dev/null
	2041 grip-commit -m "second commit" 1> /dev/null 2> /dev/null
	echo line 3 >> a
	2041 grip-add a 1> /dev/null 2> /dev/null
	echo line 4 >> a
	2041 grip-show 0:a 1> expected_output.log 2> expected_stderr.log
	2041 grip-show 1:a 1>> expected_output.log 2>> expected_stderr.log
	2041 grip-show :a 1>> expected_output.log 2>> expected_stderr.log
	2041 grip-show 0:b 1>> expected_output.log 2>> expected_stderr.log
	2041 grip-show 1:b 1>> expected_output.log 2>> expected_stderr.log
	rm -f a b
	rm -rf .grip

    if diff program_output.log expected_output.log > /dev/null && diff program_stderr.log expected_stderr.log > /dev/null; then
        echo "Passed"
        passed=$((passed+1))
    else
        echo "Failed"
        failed=$((failed+1))
    fi
	# rm -f program_output.log program_stderr.log expected_output.log expected_stderr.log
}

test6() {
	echo "Test 6 show with no commit exist:"
	./grip-init 1> /dev/null 2> /dev/null
	echo 1 > a
	echo hello world > b
	./grip-add a b 1> /dev/null 2> /dev/null
	./grip-commit -m "first commit" 1> /dev/null 2> /dev/null
	program_output=$(./grip-show 1:a 2>stderr_a.log)
	program_stderr=$(cat stderr_a.log)
	rm -f a b
	rm -rf .grip

	2041 grip-init 1> /dev/null 2> /dev/null
	echo 1 > a
	echo hello world > b
	2041 grip-add a b 1> /dev/null 2> /dev/null
	2041 grip-commit -m "first commit" 1> /dev/null 2> /dev/null
	expected_output=$(2041 grip-show 1:a 2>stderr_e.log)
	expected_stderr=$(cat stderr_e.log)
	rm -f a b
	rm -rf .grip

    if [ "$program_output" = "$expected_output" ] && [ "$program_stderr" = "$expected_stderr" ]; then
        echo "Passed"
        passed=$((passed+1))
    else
        echo "Failed"
        failed=$((failed+1))
    fi
}

test7() {
	echo "Test 7 show with no filename in index:"
	./grip-init 1> /dev/null 2> /dev/null
	echo 1 > a
	echo hello world > b
	./grip-add a b 1> /dev/null 2> /dev/null
	./grip-commit -m "first commit" 1> /dev/null 2> /dev/null
	program_output=$(./grip-show :c 2>stderr_a.log)
	program_stderr=$(cat stderr_a.log)
	rm -f a b
	rm -rf .grip

	2041 grip-init 1> /dev/null 2> /dev/null
	echo 1 > a
	echo hello world > b
	2041 grip-add a b 1> /dev/null 2> /dev/null
	2041 grip-commit -m "first commit" 1> /dev/null 2> /dev/null
	expected_output=$(2041 grip-show :c 2>stderr_e.log)
	expected_stderr=$(cat stderr_e.log)
	rm -f a b
	rm -rf .grip

    if [ "$program_output" = "$expected_output" ] && [ "$program_stderr" = "$expected_stderr" ]; then
        echo "Passed"
        passed=$((passed+1))
    else
        echo "Failed"
        failed=$((failed+1))
    fi
}

test8() {
	echo "Test 8 show with no filename in commit:"
	./grip-init 1> /dev/null 2> /dev/null
	echo 1 > a
	echo hello world > b
	./grip-add a b 1> /dev/null 2> /dev/null
	./grip-commit -m "first commit" 1> /dev/null 2> /dev/null
	program_output=$(./grip-show 0:c 2>stderr_a.log)
	program_stderr=$(cat stderr_a.log)
	rm -f a b
	rm -rf .grip

	2041 grip-init 1> /dev/null 2> /dev/null
	echo 1 > a
	echo hello world > b
	2041 grip-add a b 1> /dev/null 2> /dev/null
	2041 grip-commit -m "first commit" 1> /dev/null 2> /dev/null
	expected_output=$(2041 grip-show 0:c 2>stderr_e.log)
	expected_stderr=$(cat stderr_e.log)
	rm -f a b
	rm -rf .grip


    if [ "$program_output" = "$expected_output" ] && [ "$program_stderr" = "$expected_stderr" ]; then
        echo "Passed"
        passed=$((passed+1))
    else
        echo "Failed"
        failed=$((failed+1))
    fi
}

test9() {
	echo "Test 9 show with add got no effect:"
	./grip-init 1> /dev/null 2> /dev/null
	echo hi > a
	./grip-add a 1> /dev/null 2> /dev/null
	./grip-show :a 1> program_output.log 2> program_stderr.log
	./grip-commit -m message1 1> /dev/null 2> /dev/null
	echo there >> a
	./grip-show :a 1>> program_output.log 2>> program_stderr.log
	rm -f a
	rm -rf .grip

	2041 grip-init 1> /dev/null 2> /dev/null
	echo hi > a
	2041 grip-add a 1> /dev/null 2> /dev/null
	2041 grip-show :a 1> expected_output.log 2> expected_stderr.log
	2041 grip-commit -m message1 1> /dev/null 2> /dev/null
	echo there >> a
	2041 grip-show :a 1>> expected_output.log 2>> expected_stderr.log
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

i=1
num_tests=9
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