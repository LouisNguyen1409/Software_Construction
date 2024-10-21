#!/usr/bin/env python3
import sys

def sort_key(line):
	return (len(line), line)

filename = sys.argv[1]
with open(filename, 'r') as file:
	lines = file.readlines()

lines = [line.strip() for line in lines]

sorted_lines = sorted(lines, key=sort_key)

for line in sorted_lines:
	print(line)