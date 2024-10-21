#!/usr/bin/env python3
import sys

filename = sys.argv[1]
with open(filename, 'r') as file:
	lines = file.readlines()
	total_lines = len(lines)
	if total_lines != 0:
		middle = total_lines // 2

		if total_lines % 2 == 0:
			print(lines[middle - 1].strip())
			print(lines[middle].strip())
		else:
			print(lines[middle].strip())