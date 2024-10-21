#!/bin/dash
echo "This is a test script for give-automarking with correct solution"

rm -rf .give
echo 'echo "Hello World"' > _solution.sh
echo "default|||" > _autotest.autotests
echo "default||||1" > _automark.automarking
echo 'echo "Hello World"' > _filename.sh

echo "* Test default passed (1 marks)." > _stdout.log
echo "** 1 tests passed, 0 tests failed - mark: 1/1" >> _stdout.log
echo "" > _stderr.log

chmod 777 _solution.sh _autotest.autotests _automark.automarking _filename.sh

./give-add assignment1 _solution.sh _autotest.autotests _automark.automarking 1>/dev/null 2>/dev/null
./give-submit assignment1 z5428797 _filename.sh 1>/dev/null 2>/dev/null


actual_stdout=$(./give-mark assignment1 2>stderr.log)
actual_stdout=$(echo "$actual_stdout" | sed '1d')
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

rm _solution.sh _autotest.autotests _automark.automarking _filename.sh stderr.log _stdout.log _stderr.log 
rm -rf .give

