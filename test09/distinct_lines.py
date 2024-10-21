#!/usr/bin/env python3

import sys

n = int(sys.argv[1])
distinct_lines = set()
total_lines = 0

while len(distinct_lines) < n:
	try:
		line = input()
		total_lines += 1
		normalized_line = ' '.join(line.lower().split())
		distinct_lines.add(normalized_line)
	except EOFError:
		break

if len(distinct_lines) < n:
	print(f"End of input reached after {total_lines} lines read - {n} different lines not seen.")
else:
	print(f"{n} distinct lines seen after {total_lines} lines read.")