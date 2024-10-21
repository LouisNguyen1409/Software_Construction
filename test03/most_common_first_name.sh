#! /usr/bin/env dash

cut -d'|' -f2,3 | sort | uniq | cut -d',' -f2 | cut -d' ' -f2 | sort | uniq -c | sort -nr | head -n 1 | sed -E 's/^.*\s//'
