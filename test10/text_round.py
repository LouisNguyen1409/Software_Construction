#!/usr/bin/env python3
import sys
import re

def round_number(match):
	number = float(match.group())
	rounded = round(number)
	return str(rounded)

pattern = r'\b\d+(?:\.\d*)?|\.\d+\b'

for line in sys.stdin:
	rounded_line = re.sub(pattern, round_number, line)
	print(rounded_line, end='')