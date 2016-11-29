#!/usr/bin/python

"""uniq_dji_daily.py

this script is
"""

__author__ = 'takahiro'
__version__ = '2016-11-28 1.00 (takahiro)'

import sys
#import optparse

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

table = {}
for line in stream:
  array = line.split(',')
  if not (array[0] in table):
    table[array[0]] = array[0]
    print line,

