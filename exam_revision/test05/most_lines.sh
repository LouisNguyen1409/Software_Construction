#!/bin/dash

max_line=0
max_file=""
for file in "$@"; do
	line=$(wc -l < "$file")
	if [ "$line" -ge "$max_line" ]; then
		max_line="$line"
		max_file="$file"
	fi
done

echo "$max_file"