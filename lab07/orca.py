#!/usr/bin/env python3

import sys
filenames = sys.argv[1:]
orca_count = 0

for filename in filenames:
    with open(filename, 'r') as file:
        for line in file:
            parts = line.split()
            if len(parts) >= 3:
                num_whales = int(parts[1])
                species = " ".join(parts[2:])
                if "Orca" in species:
                    orca_count += num_whales
print(f"{orca_count} Orcas reported")
