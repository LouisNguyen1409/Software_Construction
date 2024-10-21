#! /usr/bin/env dash

cut -d'|' -f2 | sort | uniq -c | sort | grep -E '2\s.*' | sed -E 's/2\s([0-9]*)/\1/' | sed -E 's/^\s+//' | sort