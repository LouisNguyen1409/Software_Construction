#!/bin/dash
echo "This is a test script for give-submit"

echo "---------------------------------"

test1() {
    echo -n "Test 1 Valid Number of Arguments: "
    echo 'echo "Hello World"' > _solution.sh
    echo "default|||" > _autotest.autotests
    echo "default||||1" > _automark.automarking
    echo 'echo "Hello World"' > _filename.sh

    echo "" > _stderr.log
    ./give-add assignment1 _solution.sh _autotest.autotests _automark.automarking 1>/dev/null 2>/dev/null
    echo "" > _stdout.log

    actual_stdout=$(./give-submit assignment1 z5428797 _filename.sh 1>/dev/null 2>stderr.log)
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

    rm _solution.sh _autotest.autotests _automark.automarking  _filename.sh _stdout.log _stderr.log stderr.log
}

test2() {
    echo -n "Test 2 Invalid Number of Arguments: "
    echo 'echo "Hello World"' > _solution.sh
    echo "default|||" > _autotest.autotests
    echo "default||||1" > _automark.automarking
    echo 'echo "Hello World"' > _filename.sh

    echo "usage: give-submit <assignment> <zid> <filename>" > _stderr.log
    ./give-add assignment1 _solution.sh _autotest.autotests _automark.automarking 1>/dev/null 2>/dev/null
    echo "" > _stdout.log

    actual_stdout=$(./give-submit 2>stderr.log)
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

    rm _solution.sh _autotest.autotests _automark.automarking  _filename.sh _stdout.log _stderr.log stderr.log
}

test3() {
    echo -n "Test 3 Invalid Assignment Name: "
    echo 'echo "Hello World"' > _solution.sh
    echo "default|||" > _autotest.autotests
    echo "default||||1" > _automark.automarking
    echo 'echo "Hello World"' > _filename.sh

    echo "give-submit: invalid assignment: A,s.s/i}g{nment" > _stderr.log
    ./give-add assignment1 _solution.sh _autotest.autotests _automark.automarking 1>/dev/null 2>/dev/null
    echo "" > _stdout.log

    actual_stdout=$(./give-submit A,s.s/i}g{nment z5428797 _filename.sh 2>stderr.log)
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

    rm _solution.sh _autotest.autotests _automark.automarking  _filename.sh _stdout.log _stderr.log stderr.log
}

test4() {
    echo -n "Test 4 Not Found Assignment Name: "
    echo 'echo "Hello World"' > _solution.sh
    echo "default|||" > _autotest.autotests
    echo "default||||1" > _automark.automarking
    echo 'echo "Hello World"' > _filename.sh

    echo "give-submit: assignment ba2 not found" > _stderr.log
    ./give-add assignment1 _solution.sh _autotest.autotests _automark.automarking 1>/dev/null 2>/dev/null
    echo "" > _stdout.log

    actual_stdout=$(./give-submit ba2 z5428797 _filename.sh 2>stderr.log)
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

    rm _solution.sh _autotest.autotests _automark.automarking  _filename.sh _stdout.log _stderr.log stderr.log
}

test5() {
    echo -n "Test 5 Invalid ZID: "
    echo 'echo "Hello World"' > _solution.sh
    echo "default|||" > _autotest.autotests
    echo "default||||1" > _automark.automarking
    echo 'echo "Hello World"' > _filename.sh

    echo "give-submit: invalid zid: z222" > _stderr.log
    ./give-add assignment1 _solution.sh _autotest.autotests _automark.automarking 1>/dev/null 2>/dev/null
    echo "" > _stdout.log

    actual_stdout=$(./give-submit assignment1 z222 _filename.sh 2>stderr.log)
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

    rm _solution.sh _autotest.autotests _automark.automarking  _filename.sh _stdout.log _stderr.log stderr.log
}

test6() {
    echo -n "Test 6 Invalid File Name: "
    echo 'echo "Hello World"' > _solution.sh
    echo "default|||" > _autotest.autotests
    echo "default||||1" > _automark.automarking
    echo 'echo "Hello World"' > _@filename.sh

    echo "give-submit: invalid filename: _@filename.sh" > _stderr.log
    ./give-add assignment1 _solution.sh _autotest.autotests _automark.automarking 1>/dev/null 2>/dev/null
    echo "" > _stdout.log

    actual_stdout=$(./give-submit assignment1 z5428797 _@filename.sh 2>stderr.log)
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

    rm _solution.sh _autotest.autotests _automark.automarking  _@filename.sh _stdout.log _stderr.log stderr.log
}

test7() {
    echo -n "Test 7 Not Found File Name: "
    echo 'echo "Hello World"' > _solution.sh
    echo "default|||" > _autotest.autotests
    echo "default||||1" > _automark.automarking

    echo "give-submit: _filename.sh: No such file or directory" > _stderr.log
    ./give-add assignment1 _solution.sh _autotest.autotests _automark.automarking 1>/dev/null 2>/dev/null
    echo "" > _stdout.log

    actual_stdout=$(./give-submit assignment1 z5428797 _filename.sh 2>stderr.log)
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

    rm _solution.sh _autotest.autotests _automark.automarking _stdout.log _stderr.log stderr.log
}

test8() {
    echo -n "Test 8 No .give File: "
    echo 'echo "Hello World"' > _solution.sh
    echo "default|||" > _autotest.autotests
    echo "default||||1" > _automark.automarking
    echo 'echo "Hello World"' > _filename.sh

    echo "give-submit: give directory .give not found" > _stderr.log
    echo "" > _stdout.log

    actual_stdout=$(./give-submit assignment1 z5428797 _filename.sh 2>stderr.log)
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

    rm _solution.sh _autotest.autotests _automark.automarking  _filename.sh _stdout.log _stderr.log stderr.log
}

i=1
num_tests=8
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