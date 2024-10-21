#!/usr/bin/env dash
echo "This is a test script for grip-rm"
echo "---------------------------------"

test1() {
	echo "Test 1 rm with no .grip:"
	touch a
	program_output=$(./grip-rm a 2>stderr_a.log)
    program_stderr=$(cat stderr_a.log)
	rm -f a

	touch a
	expected_output=$(2041 grip-rm a 2>stderr_e.log)
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
	echo "Test 2 rm with no file:"
	./grip-init 1> /dev/null 2> /dev/null
	program_output=$(./grip-rm 2>stderr_a.log)
	program_stderr=$(cat stderr_a.log)
	rm -rf .grip

	2041 grip-init 1> /dev/null 2> /dev/null
	expected_output=$(2041 grip-rm 2>stderr_e.log)
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
	echo "Test 3 rm with no file in index:"
	./grip-init 1> /dev/null 2> /dev/null
	echo 1 >a
	./grip-add a 1> /dev/null 2> /dev/null
	./grip-commit -m "commit" 1> /dev/null 2> /dev/null
	program_output=$(./grip-rm e 2>stderr_a.log)
	program_stderr=$(cat stderr_a.log)
	rm -rf .grip a

	2041 grip-init 1> /dev/null 2> /dev/null
	echo 1 >a
	2041 grip-add a 1> /dev/null 2> /dev/null
	2041 grip-commit -m "commit" 1> /dev/null 2> /dev/null
	expected_output=$(2041 grip-rm e 2>stderr_e.log)
	expected_stderr=$(cat stderr_e.log)
	rm -rf .grip a

    if [ "$program_output" = "$expected_output" ] && [ "$program_stderr" = "$expected_stderr" ]; then
        echo "Passed"
        passed=$((passed+1))
    else
        echo "Failed"
        failed=$((failed+1))
    fi
}

test4() {
	echo "Test 4 rm with index diff repo + wd:"
	./grip-init 1> /dev/null 2> /dev/null
	echo 1 >a
	./grip-add a 1> /dev/null 2> /dev/null
	./grip-commit -m "commit" 1> /dev/null 2> /dev/null
	echo 2 >a
	./grip-add a 1> /dev/null 2> /dev/null
	echo 3 >a
	program_output=$(./grip-rm a 2>stderr_a.log)
	program_stderr=$(cat stderr_a.log)
	rm -rf .grip a

	2041 grip-init 1> /dev/null 2> /dev/null
	echo 1 >a
	2041 grip-add a 1> /dev/null 2> /dev/null
	2041 grip-commit -m "commit" 1> /dev/null 2> /dev/null
	echo 2 >a
	2041 grip-add a 1> /dev/null 2> /dev/null
	echo 3 >a
	expected_output=$(2041 grip-rm a 2>stderr_e.log)
	expected_stderr=$(cat stderr_e.log)
	rm -rf .grip a

    if [ "$program_output" = "$expected_output" ] && [ "$program_stderr" = "$expected_stderr" ]; then
        echo "Passed"
        passed=$((passed+1))
    else
        echo "Failed"
        failed=$((failed+1))
    fi
}

test5() {
	echo "Test 5 rm with index diff wd:"
	./grip-init 1> /dev/null 2> /dev/null
	echo 1 >a
	./grip-add a 1> /dev/null 2> /dev/null
	./grip-commit -m "commit" 1> /dev/null 2> /dev/null
	echo 2 >a
	program_output=$(./grip-rm a 2>stderr_a.log)
	program_stderr=$(cat stderr_a.log)
	rm -rf .grip a

	2041 grip-init 1> /dev/null 2> /dev/null
	echo 1 >a
	2041 grip-add a 1> /dev/null 2> /dev/null
	2041 grip-commit -m "commit" 1> /dev/null 2> /dev/null
	echo 2 >a
	expected_output=$(2041 grip-rm a 2>stderr_e.log)
	expected_stderr=$(cat stderr_e.log)
	rm -rf .grip a

    if [ "$program_output" = "$expected_output" ] && [ "$program_stderr" = "$expected_stderr" ]; then
        echo "Passed"
        passed=$((passed+1))
    else
        echo "Failed"
        failed=$((failed+1))
    fi
}

test6() {
	echo "Test 6 rm with index diff repo:"
	./grip-init 1> /dev/null 2> /dev/null
	echo 1 >a
	./grip-add a 1> /dev/null 2> /dev/null
	./grip-commit -m "commit" 1> /dev/null 2> /dev/null
	echo 2 >a
	./grip-add a 1> /dev/null 2> /dev/null
	program_output=$(./grip-rm a 2>stderr_a.log)
	program_stderr=$(cat stderr_a.log)
	rm -rf .grip a

	2041 grip-init 1> /dev/null 2> /dev/null
	echo 1 >a
	2041 grip-add a 1> /dev/null 2> /dev/null
	2041 grip-commit -m "commit" 1> /dev/null 2> /dev/null
	echo 2 >a
	2041 grip-add a 1> /dev/null 2> /dev/null
	expected_output=$(2041 grip-rm a 2>stderr_e.log)
	expected_stderr=$(cat stderr_e.log)
	rm -rf .grip a

    if [ "$program_output" = "$expected_output" ] && [ "$program_stderr" = "$expected_stderr" ]; then
        echo "Passed"
        passed=$((passed+1))
    else
        echo "Failed"
        failed=$((failed+1))
    fi
}

test7() {
	echo "Test 7 rm and cache with no file in index:"
	./grip-init 1> /dev/null 2> /dev/null
	touch a
	./grip-add a 1> /dev/null 2> /dev/null
	./grip-commit -m "commit" 1> /dev/null 2> /dev/null
	program_output=$(./grip-rm --cached e 2>stderr_a.log)
	program_stderr=$(cat stderr_a.log)
	rm -rf .grip a

	2041 grip-init 1> /dev/null 2> /dev/null
	touch a
	2041 grip-add a 1> /dev/null 2> /dev/null
	2041 grip-commit -m "commit" 1> /dev/null 2> /dev/null
	expected_output=$(2041 grip-rm --cached e 2>stderr_e.log)
	expected_stderr=$(cat stderr_e.log)
	rm -rf .grip a

    if [ "$program_output" = "$expected_output" ] && [ "$program_stderr" = "$expected_stderr" ]; then
        echo "Passed"
        passed=$((passed+1))
    else
        echo "Failed"
        failed=$((failed+1))
    fi
}

test8() {
	echo "Test 8 rm and cache with index diff repo + wd:"
	./grip-init 1> /dev/null 2> /dev/null
	echo 1 >a
	./grip-add a 1> /dev/null 2> /dev/null
	./grip-commit -m "commit" 1> /dev/null 2> /dev/null
	echo 2 >a
	./grip-add a 1> /dev/null 2> /dev/null
	echo 3 >a
	program_output=$(./grip-rm --cached a 2>stderr_a.log)
	program_stderr=$(cat stderr_a.log)
	rm -rf .grip a

	2041 grip-init 1> /dev/null 2> /dev/null
	echo 1 >a
	2041 grip-add a 1> /dev/null 2> /dev/null
	2041 grip-commit -m "commit" 1> /dev/null 2> /dev/null
	echo 2 >a
	2041 grip-add a 1> /dev/null 2> /dev/null
	echo 3 >a
	expected_output=$(2041 grip-rm --cached a 2>stderr_e.log)
	expected_stderr=$(cat stderr_e.log)
	rm -rf .grip a

    if [ "$program_output" = "$expected_output" ] && [ "$program_stderr" = "$expected_stderr" ]; then
        echo "Passed"
        passed=$((passed+1))
    else
        echo "Failed"
        failed=$((failed+1))
    fi
}

test9() {
	echo "Test 9 rm and cache with index diff wd:"
	./grip-init 1> /dev/null 2> /dev/null
	echo 1 >a
	./grip-add a 1> /dev/null 2> /dev/null
	./grip-commit -m "commit" 1> /dev/null 2> /dev/null
	echo 2 >a
	program_output=$(./grip-rm --cached a 2>stderr_a.log)
	program_stderr=$(cat stderr_a.log)
	rm -rf .grip a

	2041 grip-init 1> /dev/null 2> /dev/null
	echo 1 >a
	2041 grip-add a 1> /dev/null 2> /dev/null
	2041 grip-commit -m "commit" 1> /dev/null 2> /dev/null
	echo 2 >a
	expected_output=$(2041 grip-rm --cached a 2>stderr_e.log)
	expected_stderr=$(cat stderr_e.log)
	rm -rf .grip a

    if [ "$program_output" = "$expected_output" ] && [ "$program_stderr" = "$expected_stderr" ]; then
        echo "Passed"
        passed=$((passed+1))
    else
        echo "Failed"
        failed=$((failed+1))
    fi
}

test10() {
	echo "Test 10 rm and cache with index diff repo:"
	./grip-init 1> /dev/null 2> /dev/null
	echo 1 >a
	./grip-add a 1> /dev/null 2> /dev/null
	./grip-commit -m "commit" 1> /dev/null 2> /dev/null
	echo 2 >a
	./grip-add a 1> /dev/null 2> /dev/null
	program_output=$(./grip-rm --cached a 2>stderr_a.log)
	program_stderr=$(cat stderr_a.log)
	rm -rf .grip a

	2041 grip-init 1> /dev/null 2> /dev/null
	echo 1 >a
	2041 grip-add a 1> /dev/null 2> /dev/null
	2041 grip-commit -m "commit" 1> /dev/null 2> /dev/null
	echo 2 >a
	2041 grip-add a 1> /dev/null 2> /dev/null
	expected_output=$(2041 grip-rm --cached a 2>stderr_e.log)
	expected_stderr=$(cat stderr_e.log)
	rm -rf .grip a

    if [ "$program_output" = "$expected_output" ] && [ "$program_stderr" = "$expected_stderr" ]; then
        echo "Passed"
        passed=$((passed+1))
    else
        echo "Failed"
        failed=$((failed+1))
    fi
}

test11() {
	echo "Test 11 rm, cache and force no file in index:"
	./grip-init 1> /dev/null 2> /dev/null
	touch a
	./grip-add a 1> /dev/null 2> /dev/null
	./grip-commit -m "commit" 1> /dev/null 2> /dev/null
	program_output=$(./grip-rm --cached --force e 2>stderr_a.log)
	program_stderr=$(cat stderr_a.log)
	rm -rf .grip a

	2041 grip-init 1> /dev/null 2> /dev/null
	touch a
	2041 grip-add a 1> /dev/null 2> /dev/null
	2041 grip-commit -m "commit" 1> /dev/null 2> /dev/null
	expected_output=$(2041 grip-rm --cached --force e 2>stderr_e.log)
	expected_stderr=$(cat stderr_e.log)
	rm -rf .grip a

    if [ "$program_output" = "$expected_output" ] && [ "$program_stderr" = "$expected_stderr" ]; then
        echo "Passed"
        passed=$((passed+1))
    else
        echo "Failed"
        failed=$((failed+1))
    fi
}

test12() {
	echo "Test 12 rm, cache and force index diff repo + wd:"
	./grip-init 1> /dev/null 2> /dev/null
	echo 1 >a
	./grip-add a 1> /dev/null 2> /dev/null
	./grip-commit -m "commit" 1> /dev/null 2> /dev/null
	echo 2 >a
	./grip-add a 1> /dev/null 2> /dev/null
	echo 3 >a
	program_output=$(./grip-rm --cached --force a 2>stderr_a.log)
	program_stderr=$(cat stderr_a.log)
	rm -rf .grip a

	2041 grip-init 1> /dev/null 2> /dev/null
	echo 1 >a
	2041 grip-add a 1> /dev/null 2> /dev/null
	2041 grip-commit -m "commit" 1> /dev/null 2> /dev/null
	echo 2 >a
	2041 grip-add a 1> /dev/null 2> /dev/null
	echo 3 >a
	expected_output=$(2041 grip-rm --cached --force a 2>stderr_e.log)
	expected_stderr=$(cat stderr_e.log)
	rm -rf .grip a

    if [ "$program_output" = "$expected_output" ] && [ "$program_stderr" = "$expected_stderr" ]; then
        echo "Passed"
        passed=$((passed+1))
    else
        echo "Failed"
        failed=$((failed+1))
    fi
}

test13() {
	echo "Test 13 rm, cache and force index diff repo:"
	./grip-init 1> /dev/null 2> /dev/null
	echo 1 >a
	./grip-add a 1> /dev/null 2> /dev/null
	./grip-commit -m "commit" 1> /dev/null 2> /dev/null
	echo 2 >a
	./grip-add a 1> /dev/null 2> /dev/null
	program_output=$(./grip-rm --cached --force a 2>stderr_a.log)
	program_stderr=$(cat stderr_a.log)
	rm -rf .grip a

	2041 grip-init 1> /dev/null 2> /dev/null
	echo 1 >a
	2041 grip-add a 1> /dev/null 2> /dev/null
	2041 grip-commit -m "commit" 1> /dev/null 2> /dev/null
	echo 2 >a
	2041 grip-add a 1> /dev/null 2> /dev/null
	expected_output=$(2041 grip-rm --cached --force a 2>stderr_e.log)
	expected_stderr=$(cat stderr_e.log)
	rm -rf .grip a

    if [ "$program_output" = "$expected_output" ] && [ "$program_stderr" = "$expected_stderr" ]; then
        echo "Passed"
        passed=$((passed+1))
    else
        echo "Failed"
        failed=$((failed+1))
    fi
}


test14() {
	echo "Test 14 rm, cache and force index diff wd:"

    if [ "$program_output" = "$expected_output" ] && [ "$program_stderr" = "$expected_stderr" ]; then
        echo "Passed"
        passed=$((passed+1))
    else
        echo "Failed"
        failed=$((failed+1))
    fi
}

i=1
num_tests=14
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