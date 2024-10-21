#!/bin/dash
echo "This is a test script for give-autotest with correct solution"

rm -rf .give
echo 'echo "Hello World"' > _solution.sh
echo "default|||" > _autotest.autotests
echo "default||||1" > _automark.automarking
echo 'echo "Hello World"' > _filename.sh

echo "* Test default passed." > _stdout.log
echo "** 1 tests passed, 0 tests failed" >> _stdout.log
echo "" > _stderr.log

chmod 777 _solution.sh _autotest.autotests _automark.automarking _filename.sh

./give-add assignment1 _solution.sh _autotest.autotests _automark.automarking 1>/dev/null 2>/dev/null
actual_stdout=$(./give-autotest assignment1 _filename.sh 2>stderr.log)
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

rm _solution.sh _autotest.autotests _automark.automarking _filename.sh stderr.log _stdout.log _stderr.log \
rm -rf .give

