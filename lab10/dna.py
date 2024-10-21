from collections import Counter, defaultdict
import sys

def read_dna(dna_file):
    """
    Read a DNA string from a file.
    the file contains data in the following format:
    A <-> T
    G <-> C
    G <-> C
    C <-> G
    G <-> C
    T <-> A
    Output a list of touples:
    [
        ('A', 'T'),
        ('G', 'C'),
        ('G', 'C'),
        ('C', 'G'),
        ('G', 'C'),
        ('T', 'A'),
    ]
    Where either (or both) elements in the string might be missing:
    <-> T
    G <->
    G <-> C
    <->
    <-> C
    T <-> A
    Output:
    [
        ('', 'T'),
        ('G', ''),
        ('G', 'C'),
        ('', ''),
        ('', 'C'),
        ('T', 'A'),
    ]
    """
    dna_list = []
    with open(dna_file, 'r') as file:
        for line in file:
            left, right = line.strip().split('<->')
            dna_list.append((left.strip(), right.strip()))
    return dna_list


def is_rna(dna):
    """
    Given DNA in the aforementioned format,
    return the string "DNA" if the data is DNA,
    return the string "RNA" if the data is RNA,
    return the string "Invalid" if the data is neither DNA nor RNA.
    DNA consists of the following bases:
    Adenine  ('A'),
    Thymine  ('T'),
    Guanine  ('G'),
    Cytosine ('C'),
    RNA consists of the following bases:
    Adenine  ('A'),
    Uracil   ('U'),
    Guanine  ('G'),
    Cytosine ('C'),
    The data is DNA if at least 90% of the bases are one of the DNA bases.
    The data is RNA if at least 90% of the bases are one of the RNA bases.
    The data is invalid if more than 10% of the bases are not one of the DNA or RNA bases.
    Empty bases should be ignored.
    """
    counter = Counter()
    for pair in dna:
        counter[pair[0]] += 1
        counter[pair[1]] += 1

    if counter['A'] + counter['T'] + counter['G'] + counter['C'] >= (sum(counter.values()) - counter['']) * 0.9:
        return "DNA"
    if counter['A'] + counter['U'] + counter['G'] + counter['C'] >= (sum(counter.values()) - counter['']) * 0.9:
        return "RNA"
    return "Invalid"


def clean_dna(dna):
    """
    Given DNA in the aforementioned format,
    If the pair is incomplete, ('A', '') or ('', 'G'), ect
    Fill in the missing base with the match base.
    In DNA 'A' matches with 'T', 'G' matches with 'C'
    In RNA 'A' matches with 'U', 'G' matches with 'C'
    If a pair contains an invalid base the pair should be removed.
    Pairs of empty bases should be ignored.
    """
    sequence_type = is_rna(dna)
    if sequence_type == "DNA":
        valid_pairs = {'A': 'T', 'T': 'A', 'G': 'C', 'C': 'G', '': ''}
    elif sequence_type == "RNA":
        valid_pairs = {'A': 'U', 'U': 'A', 'G': 'C', 'C': 'G', '': ''}
    else:
        return []  # Return empty list for invalid sequences
    
    cleaned_sequence = []
    for base1, base2 in dna:
        if base1 not in valid_pairs or base2 not in valid_pairs:
            continue
        if base1 == '' and base2 == '':
            continue
        elif base1 == '':
            cleaned_sequence.append((valid_pairs[base2], base2))
        elif base2 == '':
            cleaned_sequence.append((base1, valid_pairs[base1]))
        else:
            cleaned_sequence.append((base1, base2))
    return cleaned_sequence

def mast_common_base(dna):
    """
    Given DNA in the aforementioned format,
    return the most common first base:
    eg. given:
    A <-> T
    G <-> C
    G <-> C
    C <-> G
    G <-> C
    T <-> A
    The most common first base is 'G'.
    Empty bases should be ignored.
    """
    counter = Counter()
    for pair in dna:
        counter[pair[0]] += 1
    return counter.most_common(1)[0][0]

def base_to_name(base):
    """
    Given a base, return the name of the base.
    The base names are:
    Adenine  ('A'),
    Thymine  ('T'),
    Guanine  ('G'),
    Cytosine ('C'),
    Uracil   ('U'),
    return the string "Unknown" if the base isn't one of the above.
    """
    name = defaultdict(lambda: "Unknown")
    name['A'] = "Adenine"
    name['T'] = "Thymine"
    name['G'] = "Guanine"
    name['C'] = "Cytosine"
    name['U'] = "Uracil"
    return name[base]
