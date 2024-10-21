#!/bin/dash

for file in *.htm; do
	new_file_name="$file"l
	if [ -e "$new_file_name" ]; then
		echo "$new_file_name exists" >&2
		exit 1
	fi
	mv "$file" "$new_file_name"
done