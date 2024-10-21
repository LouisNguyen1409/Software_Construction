#!/usr/bin/env dash
echo "This is a test script for grip-commit with -a option"
echo "---------------------------------"

test1() {
	echo "Test 1 commit with 1 file change:"
	./grip-init 1> program_output.log 2> program_stderr.log
	echo hello >a
	echo world >b
	./grip-add a b 1>> program_output.log 2>> program_stderr.log
	./grip-commit -m "first commit" 1>> program_output.log 2>> program_stderr.log
	echo line 2 >>a
	./grip-commit -a -m "second commit" 1>> program_output.log 2>> program_stderr.log
	./grip-show 0:a 1>> program_output.log 2>> program_stderr.log
	./grip-show 0:b 1>> program_output.log 2>> program_stderr.log
	./grip-show 1:a 1>> program_output.log 2>> program_stderr.log
	./grip-show 1:b 1>> program_output.log 2>> program_stderr.log
	./grip-show :a 1>> program_output.log 2>> program_stderr.log
	rm -f a b
	rm -rf .grip

	2041 grip-init 1> expected_output.log 2> expected_stderr.log
	echo hello >a
	echo world >b
	2041 grip-add a b 1>> expected_output.log 2>> expected_stderr.log
	2041 grip-commit -m "first commit" 1>> expected_output.log 2>> expected_stderr.log
	echo line 2 >>a
	2041 grip-commit -a -m "second commit" 1>> expected_output.log 2>> expected_stderr.log
	2041 grip-show 0:a 1>> expected_output.log 2>> expected_stderr.log
	2041 grip-show 0:b 1>> expected_output.log 2>> expected_stderr.log
	2041 grip-show 1:a 1>> expected_output.log 2>> expected_stderr.log
	2041 grip-show 1:b 1>> expected_output.log 2>> expected_stderr.log
	2041 grip-show :a 1>> expected_output.log 2>> expected_stderr.log
	rm -f a b
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

test2() {
	echo "Test 2 commit with all files change:"
	./grip-init 1> program_output.log 2> program_stderr.log
	echo hello >a
	echo world >b
	./grip-add a b 1>> program_output.log 2>> program_stderr.log
	./grip-commit -m "first commit" 1>> program_output.log 2>> program_stderr.log
	echo line 2 >>a
	echo line 2 >>b
	./grip-commit -a -m "second commit" 1>> program_output.log 2>> program_stderr.log
	./grip-show 0:a 1>> program_output.log 2>> program_stderr.log
	./grip-show 0:b 1>> program_output.log 2>> program_stderr.log
	./grip-show 1:a 1>> program_output.log 2>> program_stderr.log
	./grip-show 1:b 1>> program_output.log 2>> program_stderr.log
	./grip-show :a 1>> program_output.log 2>> program_stderr.log
	rm -f a b
	rm -rf .grip

	2041 grip-init 1> expected_output.log 2> expected_stderr.log
	echo hello >a
	echo world >b
	2041 grip-add a b 1>> expected_output.log 2>> expected_stderr.log
	2041 grip-commit -m "first commit" 1>> expected_output.log 2>> expected_stderr.log
	echo line 2 >>a
	echo line 2 >>b
	2041 grip-commit -a -m "second commit" 1>> expected_output.log 2>> expected_stderr.log
	2041 grip-show 0:a 1>> expected_output.log 2>> expected_stderr.log
	2041 grip-show 0:b 1>> expected_output.log 2>> expected_stderr.log
	2041 grip-show 1:a 1>> expected_output.log 2>> expected_stderr.log
	2041 grip-show 1:b 1>> expected_output.log 2>> expected_stderr.log
	2041 grip-show :a 1>> expected_output.log 2>> expected_stderr.log
	rm -f a b
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

test3() {
	echo "Test 3 commit with new file:"
	./grip-init 1> program_output.log 2> program_stderr.log
	echo line 1 >a
	./grip-add a 1>> program_output.log 2>> program_stderr.log
	./grip-commit -m "first commit" 1>> program_output.log 2>> program_stderr.log
	echo line 2 >>a
	echo world >b
	./grip-add b 1>> program_output.log 2>> program_stderr.log
	./grip-commit -a -m "second commit" 1>> program_output.log 2>> program_stderr.log
	./grip-show 0:a 1>> program_output.log 2>> program_stderr.log
	./grip-show 0:b 1>> program_output.log 2>> program_stderr.log
	./grip-show 1:a 1>> program_output.log 2>> program_stderr.log
	./grip-show 1:b 1>> program_output.log 2>> program_stderr.log
	./grip-show :a 1>> program_output.log 2>> program_stderr.log
	./grip-show :b 1>> program_output.log 2>> program_stderr.log
	rm -f a b
	rm -rf .grip

	2041 grip-init 1> expected_output.log 2> expected_stderr.log
	echo line 1 >a
	2041 grip-add a 1>> expected_output.log 2>> expected_stderr.log
	2041 grip-commit -m "first commit" 1>> expected_output.log 2>> expected_stderr.log
	echo line 2 >>a
	echo world >b
	2041 grip-add b 1>> expected_output.log 2>> expected_stderr.log
	2041 grip-commit -a -m "second commit" 1>> expected_output.log 2>> expected_stderr.log
	2041 grip-show 0:a 1>> expected_output.log 2>> expected_stderr.log
	2041 grip-show 0:b 1>> expected_output.log 2>> expected_stderr.log
	2041 grip-show 1:a 1>> expected_output.log 2>> expected_stderr.log
	2041 grip-show 1:b 1>> expected_output.log 2>> expected_stderr.log
	2041 grip-show :a 1>> expected_output.log 2>> expected_stderr.log
	2041 grip-show :b 1>> expected_output.log 2>> expected_stderr.log
	rm -f a b
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
num_tests=3
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