#!/usr/bin/env python3

import sys
import re

filename = sys.argv[1]
total_sum = 0

with open(filename, 'r') as file:
    for line in file:
        numbers = re.findall(r'\d+', line)
        total_sum += sum(int(number) for number in numbers)
print(total_sum)
