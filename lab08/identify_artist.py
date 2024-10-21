#!/usr/bin/env python3

from collections import defaultdict, Counter
from glob import glob
import math
import os
import re
import sys

data = {}
for file in glob("lyrics/*.txt"):
	artist = file.split('/')[-1].replace('.txt', '').replace('_', ' ')
	with open(file, encoding="utf-8") as f:
		words = re.findall(r"[a-zA-Z]+", f.read().lower())
	word_len = len(words)
	data[artist] = defaultdict(lambda x=math.log(1 / word_len): x)
	for word, count in Counter(words).items():
		data[artist][word] = math.log((count + 1) / word_len)


for file in sys.argv[1:]:
	with open(file, encoding="utf-8") as f:
		words = re.findall(r"[a-zA-Z]+", f.read().lower())

	artist_prob = {}
	for artist, log_prob in data.items():
		prob = sum(log_prob[w] for w in words)
		artist_prob[artist] = prob

	artist, prob = max(artist_prob.items(), key=lambda x: x[1])
	print(f"{file} most resembles the work of {artist} (log-probability={prob:.1f})")