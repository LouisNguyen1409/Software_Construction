#!/bin/dash

for filename in "$@"; do
	index=0
	while [ -e ".$filename.$index" ]; do
        index=$((index + 1))
	done

    if ! [ -f "$filename" ]; then
        continue
    fi

	if cp "$filename" ".$filename.$index"; then
        echo "Backup of '$filename' saved as '.$filename.$index'"
	else
        echo "Backup of '$filename' failed"
        exit 1
	fi
done