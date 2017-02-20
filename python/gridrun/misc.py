import os.path
import itertools
import numbers

def loadnpz(filename):
    """Load a npz file as a pandas DataFrame"""
    f = np.load(filename)
    df = pd.DataFrame(f['data'], columns=f['columns'])
    df = df.apply(pd.to_numeric, errors='ignore')
    df.sort_values(list(df.columns), inplace=True)
    return df

def progressbar(iterator):
    # if available add progress indicator
    try:
        import pyprind
        iterator = pyprind.prog_bar(iterator)
    except:
        pass
    return iterator

def parametercheck(datadir, argv, paramscomb, nbatch):
    if not os.path.exists(datadir):
        print 'datadir missing!'
        return False
    if not len(argv) > 1:
        if len(paramscomb) % nbatch != 0.0:
            print 'incompatible nbatch', len(paramscomb), nbatch
        else:
            print 'number of jobs', len(paramscomb) / nbatch
        return False
    return True

def params_combination(params):
    """Make a list of all combinations of the parameters."""
    # for itertools.product to work float entries have to be converted to 1-element lists
    params = [[p] if isinstance(p, numbers.Number) or isinstance(p, str) or hasattr(p, '__call__') else p for p in params]
    return list(itertools.product(*params))

