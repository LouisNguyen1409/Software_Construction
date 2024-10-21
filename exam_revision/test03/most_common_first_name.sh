#!/bin/dash

grep -E "(COMP2041|COMP9044)" | cut -d'|' -f3 | cut -d' ' -f2 | sort | uniq -c | sort -r | sed -E 's/.*\s//' | head -n 1