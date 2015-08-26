#!/usr/bin/python

"""extract_result.py

this script is
"""

__author__ = 'takahiro'
__version__ = '2015-08-25 1.00 (takahiro)'

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


for line in stream:
  (triger_id, entry_id, leave_id,
   triger_date, entry_date, leave_date,
   is_losscut,
   trigger_value, entry_value, leave_value,
   is_buy) = line.rstrip().split('\t')

  result = float(leave_value) - float(entry_value)
  if int(is_buy) == 0:
    result = -result

  print entry_date, result

