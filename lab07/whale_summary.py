#!/usr/bin/env python3

import sys
import collections

filenames = sys.argv[1:]
whale_data = collections.defaultdict(lambda: {'pods': 0, 'individuals': 0})

for filename in filenames:
    with open(filename, 'r') as file:
        for line in file:
            parts = line.split()
            if len(parts) >= 3:
                num_whales = int(parts[1])
                species = " ".join(parts[2:])
                species = species.lower()
                if species.endswith('s'):
                    species = species[:-1]
                whale_data[species]['pods'] += 1
                whale_data[species]['individuals'] += num_whales

for species in sorted(whale_data.keys()):
    pods = whale_data[species]['pods']
    individuals = whale_data[species]['individuals']
    print(f"{species} observations: {pods} pods, {individuals} individuals")