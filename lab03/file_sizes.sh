#! /usr/bin/env dash

small_files=""
large_files=""
medium_files=""
for file in *
do
	# echo "$file"
	lines=$(wc -l < "$file")
	# echo "$lines"
	if [ "$lines" -lt 10 ]
	then
		small_files="$small_files $file"
	elif [ "$lines" -gt 100 ]
	then
		large_files="$large_files $file"
	else
		medium_files="$medium_files $file"
	fi
done

echo "Small files:$small_files"
echo "Medium-sized files:$medium_files"
echo "Large files:$large_files"
exit 0
