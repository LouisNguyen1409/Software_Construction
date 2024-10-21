#!/bin/dash

num=$(grep -E "^$1\|" "$2" | cut -d'|' -f2 | sort -n | uniq)
start=$(echo "$num" | head -n1)
end=$(echo "$num" | tail -n1)

for year in $(seq "$start" "$end"); do
    if ! echo "$num" | grep -q "$year"; then
        echo "$year"
    fi
done