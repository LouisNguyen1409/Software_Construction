#!/usr/bin/env python3

import sys
from glob import glob
import re
from collections import defaultdict

target = sys.argv[1].lower()

word_counts = defaultdict(lambda: defaultdict(int))
total_counts = defaultdict(int)

for file in glob("lyrics/*.txt"):
	artist = file.split('/')[-1].replace('.txt', '').replace('_', ' ')

	with open(file, 'r') as f:
		lyrics = f.read().lower()
		words = re.findall(r'[a-z]+', lyrics)
		total_counts[artist] += len(words)
		word_counts[artist][target] += words.count(target)

for artist in sorted(word_counts):
	word_count = word_counts[artist][target]
	total_count = total_counts[artist]
	if total_count:
		frequency = word_count / total_count
	else:
		frequency = 0
	print(f"{word_count:4}/{total_count:6} = {frequency:.9f} {artist}")

