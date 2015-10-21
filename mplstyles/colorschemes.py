import os.path
import glob
import csv
from matplotlib import colors

for filename in glob.glob('../colorschemes/*.gpl'):
    colorlist = []
    with open(filename, 'r') as csvfile:
        reader = csv.reader(csvfile, delimiter=' ', skipinitialspace=True)
        started = False
        for row in reader:
            if started:
                hex_ = colors.rgb2hex([float(x)/255.0 for x in row[:3]])
                colorlist.append(str(hex_[1:]).upper())
            if row[0] == '#':
                started = True

    with open('c_%s.mplstyle' % os.path.splitext(os.path.basename(filename))[0], 'w') as stylefile:
        stylefile.write("axes.prop_cycle: cycler('color', %s)\n" % colorlist)
