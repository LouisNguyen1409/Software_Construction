#!/usr/bin/env python3

import sys
import re


lines = []
max_number = None
max_lines = []

for line in sys.stdin:
    lines.append(line.rstrip())

for line in lines:
    numbers = list(map(float, re.findall(r'[+-]?(?:[0-9]+\.?[0-9]*|\.[0-9]+)', line)))
    if numbers:
        max_in_line = max(numbers)
        if max_number is None or max_in_line > max_number:
            max_number = max_in_line
            max_lines = [line]
        elif max_in_line == max_number:
            max_lines.append(line)

for line in max_lines:
    print(line)

