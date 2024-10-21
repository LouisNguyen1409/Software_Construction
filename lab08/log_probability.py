#!/usr/bin/env python3

from glob import glob
import math
import os
import re
import sys
from collections import defaultdict

word_counts = defaultdict(lambda: defaultdict(int))
total_counts = defaultdict(int)

for file in glob("lyrics/*.txt"):
    artist = file.split('/')[-1].replace('.txt', '').replace('_', ' ')

    with open(file, 'r') as f:
        lyrics = f.read().lower()
        words = re.findall(r'[a-z]+', lyrics)
        total_counts[artist] += len(words)
        for word in words:
            word_counts[artist][word] += 1

for artist in sorted(word_counts):
	prob = 0
	for word in sys.argv[1:]:
		word_count = word_counts[artist][word.lower()]
		total_words = sum(word_counts[artist].values())
		prob += math.log((word_count + 1) / total_words)
	print(f"{prob:10.5f} {artist}")