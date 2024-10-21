#!/bin/dash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <directory1> <directory2>" 1>&2
    exit 1
fi

dir1=$1
dir2=$2

for file in "$dir1"/*; do
    filename=$(basename "$file")
    if [ -f "$dir2/$filename" ]; then
        if cmp -s "$file" "$dir2/$filename"; then
            echo "$filename"
        fi
    fi
done | sort