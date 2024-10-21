#!/bin/dash

for file in "$@"
do
    check_files=$(grep -E '^#include\s*"' "$file" | sed -E 's/[^"]*"//;s/"*$//')
    for check_file in $check_files
    do
        if [ ! -e "$check_file" ]
        then
            echo "$check_file included into $file does not exist"
        fi
    done
done