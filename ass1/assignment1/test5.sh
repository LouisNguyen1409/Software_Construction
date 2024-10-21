#!/bin/dash
echo "This is a test script for give-rm"

echo "---------------------------------"

test1() {
    echo -n "Test 1 Valid Number of Arguments: "
    echo 'echo "Hello World"' > _solution.sh
    echo "default|||" > _autotest.autotests
    echo "default||||1" > _automark.automarking
    echo 'echo "Hello World Old"' > _filename_old.sh
    echo 'echo "Hello World"' > _filename.sh

    ./give-add assignment1 _solution.sh _autotest.autotests _automark.automarking 1>/dev/null 2>/dev/null
    ./give-submit assignment1 z5555555 _filename_old.sh 1>/dev/null 2>/dev/null
    ./give-submit assignment1 z6666666 _filename_old.sh 1>/dev/null 2>/dev/null
    ./give-submit assignment1 z7777777 _filename_old.sh 1>/dev/null 2>/dev/null
    ./give-submit assignment1 z6666666 _filename.sh 1>/dev/null 2>/dev/null
    ./give-submit assignment1 z5555555 _filename.sh 1>/dev/null 2>/dev/null
    ./give-submit assignment1 z7777777 _filename.sh 1>/dev/null 2>/dev/null

    echo "" > _stderr.log
    echo 'assignment assignment1 removed' > _stdout.log

    actual_stdout=$(./give-rm assignment1 2>stderr.log)
    actual_stderr=$(cat stderr.log)
    expected_stdout=$(cat _stdout.log)
    expected_stderr=$(cat _stderr.log)

    if [ "$actual_stdout" = "$expected_stdout" ] && [ "$actual_stderr" = "$expected_stderr" ]; then
        echo "Passed"
        passed=$((passed+1))
    else
        echo "Failed"
        failed=$((failed+1))
    fi

    rm _solution.sh _autotest.autotests _automark.automarking _filename.sh _filename_old.sh _stdout.log _stderr.log stderr.log
}

test2() {
    echo -n "Test 2 Assignment Not Found: "
    echo 'echo "Hello World"' > _solution.sh
    echo "default|||" > _autotest.autotests
    echo "default||||1" > _automark.automarking
    echo 'echo "Hello World Old"' > _filename_old.sh
    echo 'echo "Hello World"' > _filename.sh

    ./give-add assignment1 _solution.sh _autotest.autotests _automark.automarking 1>/dev/null 2>/dev/null

    echo "give-rm: assignment assignment2 not found" > _stderr.log
    echo "" > _stdout.log

    actual_stdout=$(./give-rm assignment2 2>stderr.log)
    actual_stderr=$(cat stderr.log)
    expected_stdout=$(cat _stdout.log)
    expected_stderr=$(cat _stderr.log)

    if [ "$actual_stdout" = "$expected_stdout" ] && [ "$actual_stderr" = "$expected_stderr" ]; then
        echo "Passed"
        passed=$((passed+1))
    else
        echo "Failed"
        failed=$((failed+1))
    fi

    rm _solution.sh _autotest.autotests _automark.automarking _filename.sh _filename_old.sh _stdout.log _stderr.log stderr.log
}

test3() {
    echo -n "Test 3 No .give Directory: "
    echo "give-rm: give directory .give not found" > _stderr.log
    echo "" > _stdout.log

    actual_stdout=$(./give-rm assignment2 2>stderr.log)
    actual_stderr=$(cat stderr.log)
    expected_stdout=$(cat _stdout.log)
    expected_stderr=$(cat _stderr.log)

    if [ "$actual_stdout" = "$expected_stdout" ] && [ "$actual_stderr" = "$expected_stderr" ]; then
        echo "Passed"
        passed=$((passed+1))
    else
        echo "Failed"
        failed=$((failed+1))
    fi

    rm _stdout.log _stderr.log stderr.log
}

test4() {
    echo -n "Test 4 Invalid Number of Arguments: "
    echo 'echo "Hello World"' > _solution.sh
    echo "default|||" > _autotest.autotests
    echo "default||||1" > _automark.automarking
    echo 'echo "Hello World Old"' > _filename_old.sh
    echo 'echo "Hello World"' > _filename.sh

    ./give-add assignment1 _solution.sh _autotest.autotests _automark.automarking 1>/dev/null 2>/dev/null
    ./give-submit assignment1 z5555555 _filename_old.sh 1>/dev/null 2>/dev/null
    ./give-submit assignment1 z6666666 _filename_old.sh 1>/dev/null 2>/dev/null
    ./give-submit assignment1 z7777777 _filename_old.sh 1>/dev/null 2>/dev/null
    ./give-submit assignment1 z6666666 _filename.sh 1>/dev/null 2>/dev/null
    ./give-submit assignment1 z5555555 _filename.sh 1>/dev/null 2>/dev/null
    ./give-submit assignment1 z7777777 _filename.sh 1>/dev/null 2>/dev/null

    echo "usage: give-rm <assignment>" > _stderr.log
    echo "" > _stdout.log

    actual_stdout=$(./give-rm 2>stderr.log)
    actual_stderr=$(cat stderr.log)
    expected_stdout=$(cat _stdout.log)
    expected_stderr=$(cat _stderr.log)

    if [ "$actual_stdout" = "$expected_stdout" ] && [ "$actual_stderr" = "$expected_stderr" ]; then
        echo "Passed"
        passed=$((passed+1))
    else
        echo "Failed"
        failed=$((failed+1))
    fi

    rm _solution.sh _autotest.autotests _automark.automarking _filename.sh _filename_old.sh _stdout.log _stderr.log stderr.log
}

test5() {
    echo -n "Test 5 Invalid Assignment: "
    echo 'echo "Hello World"' > _solution.sh
    echo "default|||" > _autotest.autotests
    echo "default||||1" > _automark.automarking
    echo 'echo "Hello World Old"' > _filename_old.sh
    echo 'echo "Hello World"' > _filename.sh

    ./give-add assignment1 _solution.sh _autotest.autotests _automark.automarking 1>/dev/null 2>/dev/null
    ./give-submit assignment1 z5555555 _filename_old.sh 1>/dev/null 2>/dev/null
    ./give-submit assignment1 z6666666 _filename_old.sh 1>/dev/null 2>/dev/null
    ./give-submit assignment1 z7777777 _filename_old.sh 1>/dev/null 2>/dev/null
    ./give-submit assignment1 z6666666 _filename.sh 1>/dev/null 2>/dev/null
    ./give-submit assignment1 z5555555 _filename.sh 1>/dev/null 2>/dev/null
    ./give-submit assignment1 z7777777 _filename.sh 1>/dev/null 2>/dev/null

    echo "give-rm: invalid assignment: A,s.s/i}g{nment" > _stderr.log
    echo "" > _stdout.log

    actual_stdout=$(./give-rm A,s.s/i}g{nment 2>stderr.log)
    actual_stderr=$(cat stderr.log)
    expected_stdout=$(cat _stdout.log)
    expected_stderr=$(cat _stderr.log)

    if [ "$actual_stdout" = "$expected_stdout" ] && [ "$actual_stderr" = "$expected_stderr" ]; then
        echo "Passed"
        passed=$((passed+1))
    else
        echo "Failed"
        failed=$((failed+1))
    fi

    rm _solution.sh _autotest.autotests _automark.automarking _filename.sh _filename_old.sh _stdout.log _stderr.log stderr.log
}



i=1
num_tests=5
passed=0
failed=0
while [ $i -le $num_tests ]; do
    rm -rf .give
    test_name="test$i"
    # Check if the function is defined and call it
    if command -v "$test_name" > /dev/null 2>&1; then
        "$test_name"
    else
        echo "Function $test_name not defined"
    fi
    i=$((i + 1))
    echo "---------------------------------"
    rm -rf .give
done
echo "** $passed tests passed, $failed tests failed - mark: $passed/$num_tests"