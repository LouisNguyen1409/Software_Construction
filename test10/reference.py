#!/usr/bin/env python3
import sys
import re

lines = sys.stdin.readlines()

for line in lines:
    if line.endswith('\n'):
        line = line[:-1]
    match = re.fullmatch(r'#(\d+)', line)
    if match:
        reference_number = int(match.group(1))
        print(lines[reference_number - 1], end='')
    else:
        print(line)