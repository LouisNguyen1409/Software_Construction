#!/usr/bin/env python3

import sys

def calculate_mean(numbers):
	result = sum(numbers) / len(numbers)
	return int(result) if result.is_integer() else result

def calculate_median(numbers):
	sorted_numbers = sorted(numbers)
	mid = len(sorted(numbers)) // 2
	return sorted_numbers[mid]

def calculate_mode(numbers):
	counts = {}
	for num in numbers:
		counts[num] = counts.get(num, 0) + 1
	max_count = max(counts.values())
	modes = [num for num in numbers if counts[num] == max_count]
	return modes[0]

def product(numbers):
	result = 1
	for num in numbers:
		result *= num
	return result

numbers = [int(arg) for arg in sys.argv[1:]]

print(f"count={len(numbers)}")
print(f"unique={len(set(numbers))}")
print(f"minimum={min(numbers)}")
print(f"maximum={max(numbers)}")
print(f"mean={calculate_mean(numbers)}")
print(f"median={calculate_median(numbers)}")
print(f"mode={calculate_mode(numbers)}")
print(f"sum={sum(numbers)}")
print(f"product={product(numbers)}")