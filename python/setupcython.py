# Template for how to use distutils with cython
# run with python setupcython.py build_ext --inplace

from distutils.core import setup, Extension
from Cython.Distutils import build_ext
import numpy.distutils.misc_util

include_dirs = numpy.distutils.misc_util.get_numpy_include_dirs()

setup(name='package',
      version='1.0',
      ext_modules=[Extension('package', ['package.pyx'], include_dirs=include_dirs, extra_compile_args=["-O3"])],
      cmdclass={'build_ext' : build_ext}
      )
