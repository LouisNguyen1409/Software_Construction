#!/bin/dash

for file in *.htm
do
		newfile="$file"l
		if test -e "$newfile"
		then
			echo "$newfile exists" 1>&2
			exit 1
		else
			mv "$file" "$newfile"
		fi
done