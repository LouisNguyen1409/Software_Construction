#! /usr/bin/env python3

import sys

with open(sys.argv[1]) as f:
	lines1 = f.readlines()

with open(sys.argv[2]) as f:
	lines2 = f.readlines()
	lines2.reverse()

if (len(lines1) != len(lines2)):
    print(f"Not mirrored: different number of lines: {len(lines1)} versus {len(lines2)}")
elif (lines1 != lines2):
	index = 0
	for line1 in lines1:
		if (lines1[index] != lines2[index]):
			print(f"Not mirrored: line {index + 1} different")
			break
		index+=1
else:
    print("Mirrored")
