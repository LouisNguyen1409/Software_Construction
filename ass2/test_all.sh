#!/usr/bin/env dash

i=0
num_tests=9
while [ $i -le $num_tests ]; do
    test_name="./test$i.sh"
    # Check if the function is defined and call it
    if command -v "$test_name" > /dev/null 2>&1; then
        "$test_name"
    else
        echo "Function $test_name not defined"
    fi
    i=$((i + 1))
done