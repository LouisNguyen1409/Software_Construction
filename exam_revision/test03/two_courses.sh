#!/bin/dash

cut -d'|' -f2 | sort | uniq -c | sort -r | grep -E "\s2.*" | sed -E "s/\s*2\s(.*)/\1/" | sort