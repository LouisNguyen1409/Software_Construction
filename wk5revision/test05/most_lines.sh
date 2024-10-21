#!/bin/dash

max_lines=0
max_file=""

for file in "$@"; do
    lines=$(wc -l < "$file")
    if [ "$lines" -gt "$max_lines" ]; then
        max_lines=$lines
        max_file=$file
    fi
done

echo "$max_file"