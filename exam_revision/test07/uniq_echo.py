#!/usr/bin/env python3

import sys

temp = []
index = 0
for arg in sys.argv[1:]:
	if (index == len(sys.argv) - 1 and not(arg  in temp)):
		print(arg)
	elif not (arg in temp):
		print(arg, end=' ')
		temp.append(arg)
print()