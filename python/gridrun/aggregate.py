#! /usr/bin/env python
# aggregate results by concatenating npz files
# directory specified as command line argument
# output filename optionally specified by second command line argument

import glob
import os.path
import sys
import numpy as np

files = sorted(glob.glob(sys.argv[1] + '*.npz'))
data = []
columns = None
for file_ in files:
    f = np.load(file_)
    if columns is not None:
        if not (f['columns'] == columns).all():
            print 'columns not compatible in file {}'.format(file_), columns, f['columns']
    else:
        try:
            columns = f['columns']
            dataarr = 'data'
        except:
            dataarr = f.files[0]
    data.append(f[dataarr])
fulldata = np.concatenate(data)
outname = 'aggregated' if len(sys.argv) < 3 else sys.argv[2]
outpath = os.path.join(os.path.dirname(sys.argv[1]), outname)
if columns is not None:
    np.savez_compressed(outpath, data=fulldata, columns=columns)
else:
    np.savez_compressed(outpath, fulldata)
