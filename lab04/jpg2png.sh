#!/bin/dash

for jpg in *.jpg
do
	png=$(echo "$jpg" | sed -E 's/.jpg$/.png/')
	if [ -e "$png" ]
	then
		echo "$png" already exists
		exit 1
	fi
	convert "$jpg" "$png" 2> /dev/null && rm "$jpg"
done