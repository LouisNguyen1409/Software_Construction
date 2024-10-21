#!/usr/bin/env python3
import sys

args = sys.argv[1:]
result = []
for arg in args:
	is_has = False
	vowels = 'aeiouAEIOU'
	count = 0
	for letter in arg:
		if letter in vowels:
			count += 1
			if count == 3:
				is_has = True
		else:
			count = 0

	if is_has:
		result.append(arg)

print(' '.join(result))