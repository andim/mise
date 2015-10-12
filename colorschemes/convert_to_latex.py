#!/usr/bin/env python

import csv
import sys

with open(sys.argv[1], 'r') as csvfile:
    reader = csv.reader(csvfile, delimiter=' ', skipinitialspace=True)
    started = False
    for row in reader:
        if started:
            print '\definecolor{%s}{RGB}{%s,%s,%s}'% (row[3], row[0], row[1], row[2])
        if row[0] == '#':
            started = True
