#!/bin/dash

small=""
med=""
large=""
for file in *
do
	if [ ! -f "${file}" ]; then
		continue
	fi
	lines=$(wc -l < "${file}")

	if [ "$lines" -lt 10 ]; then
		small="${small} ${file}"
	elif [ "$lines" -lt 100 ]; then
		med="${med} ${file}"
	else
		large="${large} ${file}"
	fi
done

echo "Small files:${small}"
echo "Medium-sized files:${med}"
echo "Large files:${large}"
