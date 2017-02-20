# evaluate a function for different parameter choices on a cluster
# stores results as tabular data with columns = [*params, *res] 
# aggregate all the results into a single file using aggregate.py
# philosophy: do things simply and robustly

import sys
import numpy as np
from misc import *

## dummy function replace by whatever interesting you want to do

def dostuff(param1, param2):
    return [1.0, 2.0]

## parameter definitions
param1s = 1.0
param2s = [2.0, 5.0, 10.0]

nbatch = 1
disp = False
datadir = 'data/'
outname = 'scan'

paramscomb = params_combination((param1s, param2s))
columns = ['param1', 'param2', 'res1', 'res2']
if parametercheck(datadir, sys.argv, paramscomb, nbatch):
    njob = int(sys.argv[1])
    data = []
    for i in progressbar(range(nbatch)):
        n = (njob-1) * nbatch + i
        if disp:
            print paramscomb[n]
        res = dostuff(*paramscomb[n])
        row = list(paramscomb[n])
        row.extend(res)
        data.append(row)
    np.savez_compressed(datadir + '%s%g' % (outname, njob), data=data, columns=columns)
