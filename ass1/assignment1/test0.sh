#!/bin/dash
echo "This is a test script for give-add"

echo "---------------------------------"

test1() {
    echo -n "Test 1 Valid Number of Arguments: "
    echo 'echo "Hello World"' > _solution.sh
    echo "default|||" > _autotest.autotests
    echo "default||||1" > _automark.automarking
    echo "directory .give created" > _stdout.log
    echo "assignment assignment1 created" >> _stdout.log
    echo "" > _stderr.log

    actual_stdout=$(./give-add assignment1 _solution.sh _autotest.autotests _automark.automarking 2>stderr.log)
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

test2() {
    echo -n "Test 2 Invalid Number of Arguments: "

    echo "" > _stdout.log
    echo "usage: give-add <assignment> <solution> <autotests> <automarking>" > _stderr.log

    actual_stdout=$(./give-add 2>stderr.log)
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

test3() {
    echo -n "Test 3 Invalid Assignment Name: "

    echo "echo 'Hello World'" > _solution.sh
    echo "default|||" > _autotest.autotests
    echo "default||||1" > _automark.automarking
    echo "" > _stdout.log
    echo "give-add: invalid assignment: A,s.s/i}g{nment" > _stderr.log

    actual_stdout=$(./give-add A,s.s/i}g{nment _solution.sh _autotest.autotests _automark.automarking 2>stderr.log)
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

test4() {
    echo -n "Test 4 Invalid Solution Name: "

    echo "echo 'Hello World'" > l=@#%^~.sh
    echo "default|||" > _autotest.autotests
    echo "default||||1" > _automark.automarking
    echo "" > _stdout.log
    echo "give-add: invalid solution: l=@#%^~.sh" > _stderr.log

    actual_stdout=$(./give-add assignment1 l=@#%^~.sh _autotest.autotests _automark.automarking 2>stderr.log)
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

    rm l=@#%^~.sh _autotest.autotests _automark.automarking _stdout.log _stderr.log stderr.log
}

test5() {
    echo -n "Test 5 Invalid Autotest First Column with Special Characters: "

    echo "echo 'Hello World'" > _solution.sh
    echo "l=@#%^~|||" > _autotest.autotests
    echo "default||||1" > _automark.automarking
    echo "directory .give created" > _stdout.log
    echo "give-add: _autotest.autotests:1: invalid test label: l=@#%^~" > _stderr.log

    actual_stdout=$(./give-add assignment1 _solution.sh _autotest.autotests _automark.automarking 2>stderr.log)
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

test6() {
    echo -n "Test 6 Invalid Autotest First Column with Duplicate Test Label: "
    echo "echo 'Hello World'" > _solution.sh
    echo "default|||" > _autotest.autotests
    echo "default||s|" >> _autotest.autotests
    echo "default||||1" > _automark.automarking
    echo "directory .give created" > _stdout.log
    echo "give-add: _autotest.autotests:2: repeated test label: default" > _stderr.log

    actual_stdout=$(./give-add assignment1 _solution.sh _autotest.autotests _automark.automarking 2>stderr.log)
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

test7() {
    echo -n "Test 7 Invalid Automark Third Column with \\\\t: "
    echo "echo 'Hello World'" > _solution.sh
    echo "default||\t|" > _autotest.autotests
    echo "default||||1" > _automark.automarking
    echo "directory .give created" > _stdout.log
    printf 'give-add: _autotest.autotests:1: invalid test stdin: \\\\t\n' > _stderr.log

    actual_stdout=$(./give-add assignment1 _solution.sh _autotest.autotests _automark.automarking 2>stderr.log)
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
    echo -n "Test 7 Invalid Automark Third Column with \: "
    echo "echo 'Hello World'" > _solution.sh
    echo "default||\|" > _autotest.autotests
    echo "default||||1" > _automark.automarking
    echo "directory .give created" > _stdout.log
    echo "give-add: _autotest.autotests:1: invalid test stdin: \\\\" > _stderr.log

    actual_stdout=$(./give-add assignment1 _solution.sh _autotest.autotests _automark.automarking 2>stderr.log)
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

test9() {
    echo -n "Test 9 Invalid Automark Fourth Column with other than bcdw: "
    echo "echo 'Hello World'" > _solution.sh
    echo "default|||asd" > _autotest.autotests
    echo "default||||1" > _automark.automarking
    echo "directory .give created" > _stdout.log
    echo "give-add: _autotest.autotests:1: invalid test options: asd" > _stderr.log

    actual_stdout=$(./give-add assignment1 _solution.sh _autotest.autotests _automark.automarking 2>stderr.log)
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

test10() {
    echo -n "Test 10 Invalid Automarking First Column with Special Characters: "

    echo "echo 'Hello World'" > _solution.sh
    echo "default|||" > _autotest.autotests
    echo "l=@#%^~||||1" > _automark.automarking
    echo "directory .give created" > _stdout.log
    echo "give-add: _automark.automarking:1: invalid test label: l=@#%^~" > _stderr.log

    actual_stdout=$(./give-add assignment1 _solution.sh _autotest.autotests _automark.automarking 2>stderr.log)
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

test11() {
    echo -n "Test 11 Invalid Automarking First Column with Duplicate Test Label: "
    echo "echo 'Hello World'" > _solution.sh
    echo "default|||" > _autotest.autotests
    echo "default||||1" > _automark.automarking
    echo "default||s||1" >> _automark.automarking
    echo "directory .give created" > _stdout.log
    echo "give-add: _automark.automarking:2: repeated test label: default" > _stderr.log

    actual_stdout=$(./give-add assignment1 _solution.sh _autotest.autotests _automark.automarking 2>stderr.log)
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

test12() {
    echo -n "Test 12 Invalid Automarking Third Column with \\\\t: "
    echo "echo 'Hello World'" > _solution.sh
    echo "default|||" > _autotest.autotests
    echo "default||\t||1" > _automark.automarking
    echo "directory .give created" > _stdout.log
    printf 'give-add: _automark.automarking:1: invalid test stdin: \\\\t\n' > _stderr.log

    actual_stdout=$(./give-add assignment1 _solution.sh _autotest.autotests _automark.automarking 2>stderr.log)
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

test13() {
    echo -n "Test 13 Invalid Automarking Third Column with \: "
    echo "echo 'Hello World'" > _solution.sh
    echo "default|||" > _autotest.autotests
    echo "default||\||1" > _automark.automarking
    echo "directory .give created" > _stdout.log
    echo "give-add: _automark.automarking:1: invalid test stdin: \\\\" > _stderr.log

    actual_stdout=$(./give-add assignment1 _solution.sh _autotest.autotests _automark.automarking 2>stderr.log)
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

test14() {
    echo -n "Test 14 Invalid Automarking Fourth Column with other than bcdw: "
    echo "echo 'Hello World'" > _solution.sh
    echo "default|||" > _autotest.autotests
    echo "default|||asd|1" > _automark.automarking
    echo "directory .give created" > _stdout.log
    echo "give-add: _automark.automarking:1: invalid test options: asd" > _stderr.log

    actual_stdout=$(./give-add assignment1 _solution.sh _autotest.autotests _automark.automarking 2>stderr.log)
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

test15() {
    echo -n "Test 15 No Solution File: "
    echo "default|||" > _autotest.autotests
    echo "default||||1" > _automark.automarking
    echo "directory .give created" > _stdout.log
    echo "give-add: _solution.sh: No such file or directory" > _stderr.log

    actual_stdout=$(./give-add assignment1 _solution.sh _autotest.autotests _automark.automarking 2>stderr.log)
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

    rm _autotest.autotests _automark.automarking _stdout.log _stderr.log stderr.log
}

test16() {
    echo -n "Test 16 No Autotest File: "
    echo "echo 'Hello World'" > _solution.sh
    echo "default||||1" > _automark.automarking
    echo "directory .give created" > _stdout.log
    echo "give-add: _autotest.autotests: No such file or directory" > _stderr.log

    actual_stdout=$(./give-add assignment1 _solution.sh _autotest.autotests _automark.automarking 2>stderr.log)
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

    rm _solution.sh _automark.automarking _stdout.log _stderr.log stderr.log
}

test17() {
    echo -n "Test 17 No Automarking File: "
    echo "echo 'Hello World'" > _solution.sh
    echo "default|||" > _autotest.autotests
    echo "directory .give created" > _stdout.log
    echo "give-add: _automark.automarking: No such file or directory" > _stderr.log

    actual_stdout=$(./give-add assignment1 _solution.sh _autotest.autotests _automark.automarking 2>stderr.log)
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

    rm _solution.sh _autotest.autotests _stdout.log _stderr.log stderr.log
}

i=1
num_tests=17
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