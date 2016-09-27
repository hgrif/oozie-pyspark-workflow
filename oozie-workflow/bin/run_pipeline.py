import pandas as pd
import sys

from pyspark import SparkContext
from pyspark.sql import HiveContext

# You may not need this:
# Change .python-eggs folder because my user doesn't have a $HOME on the
# cluster, resulting in PYTHON_EGG_CACHE errors on the driver.
import os
os.environ['PYTHON_EGG_CACHE'] = '/tmp/'
os.environ['PYTHON_EGG_DIR'] = '/tmp/'

import pythonproject


if __name__ == '__main__':
    date = pd.to_datetime(sys.argv[1])
    hc = HiveContext(SparkContext.getOrCreate())
    pythonproject.pipeline.run(hc, date)
