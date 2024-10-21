#!/bin/dash
echo "This is a test script for give-autotest with wrong solution"

rm -rf .give
echo 'echo "Hello World"' > _solution.sh
echo "default|||" > _autotest.autotests
echo "default||||1" > _automark.automarking
echo 'echo "Hello World Wrong"' > _filename.sh

printf "%s\n" "* Test default failed." > _stdout.log
printf "%s\n" "--- Incorrect stdout of 18 bytes:" >> _stdout.log
printf "%s\n" "Hello World Wrong" >> _stdout.log
printf "\n" >> _stdout.log
printf "%s\n" "--- Correct stdout is these 12 bytes:" >> _stdout.log
printf "%s\n" "Hello World" >> _stdout.log
printf "\n" >> _stdout.log
echo "** 0 tests passed, 1 tests failed\n" >> _stdout.log
echo "" > _stderr.log

chmod 777 _solution.sh _autotest.autotests _automark.automarking _filename.sh

./give-add assignment1 _solution.sh _autotest.autotests _automark.automarking 1>/dev/null 2>/dev/null
actual_stdout=$(./give-autotest assignment1 _filename.sh 1>stdout.log 2>stderr.log)
actual_stdout=$(cat stdout.log)
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

rm _solution.sh _autotest.autotests _automark.automarking _filename.sh stderr.log _stderr.log stdout.log _stdout.log
rm -rf .give

