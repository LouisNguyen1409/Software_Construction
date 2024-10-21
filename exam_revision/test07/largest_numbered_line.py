#!/usr/bin/env python3

import sys
import re
from collections import defaultdict

lines = sys.stdin.readlines()

data = {}

for line in lines:
	nums = re.findall(r"[+-]?[0-9]+\.?[0-9]*|\.[0-9]+", line.strip())
	if nums == []:
		continue

	temp = []
	for num in nums:
		temp.append(float(num))

	max_num = max(temp)
	if max_num in data:
		data[max_num].append(line.strip())
	else:
		data[max_num] = [line.strip()]

count = 0
max_value = 0

for value in data:
	if count == 0:
		max_value = value
	elif max_value < value:
		max_value = value
	count+=1

# print(data)
for value in data:
	if value == max_value:
		for line in data[value]:
			print(line, end='')
			print()

