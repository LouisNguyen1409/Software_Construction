#! /usr/bin/env python3

import sys

surenames = set()
for line in sys.stdin:
	_, _, name, _, gender = line.strip().split("|")
	if (gender == "M") :
		surename, _ = name.split(",")
		surenames.add(surename)

for i in sorted(surenames):
	print(i)