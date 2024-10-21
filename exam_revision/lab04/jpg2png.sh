#!/bin/dash

for file in *.jpg
do
	filename=$(echo "$file" | sed -E "s/(.*).jpg/\1/")
	filepng="${filename}.png"
	if [ -e "$filepng" ]; then
		echo "${filepng} already exists"
		exit 1
	fi
	convert "$file" "$filepng" 2> /dev/null
	rm -rf "$file"
done