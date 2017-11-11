#!/usr/bin/python

"""make_latest_dji_daily_csv.py

this script is
"""

__author__ = 'takahiro'
__version__ = '2016-11-28 1.00 (takahiro)'

import sys
#import optparse

import json
import datetime

#usage = "%prog [options] [filename]"
#parser = optparse.OptionParser(usage=usage)
#parser.add_option('-n', '--name', dest='name', help='Your Name')
#(options, args) = parser.parse_args()

if len(sys.argv) == 1:
  stream = sys.stdin
elif len(sys.argv) == 2:
  stream = open(sys.argv[1], 'r')
else:
  parser.print_help()
  exit()


data = json.load(stream)

quote = data['chart']['result'][0]['indicators']['quote'][0]
unadjclose = data['chart']['result'][0]['indicators']['unadjclose'][0]['unadjclose']
timestamps = data['chart']['result'][0]['timestamp']

for n in range(0, len(quote['open'])):
  dt = datetime.datetime.fromtimestamp(int(timestamps[n])).strftime("%Y-%m-%d")
  open = quote['open'][n]
  high = quote['high'][n]
  low = quote['low'][n]
  close = quote['close'][n]
  volume = quote['volume'][n]
  adjclose = unadjclose[n]

  print "%s,%f,%f,%f,%f,%f,%f" % (dt, open, high, low, close, adjclose, volume)


