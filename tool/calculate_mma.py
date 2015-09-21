#!/usr/bin/python

"""calculate_mma.py

this script is
"""

__author__ = 'takahiro'
__version__ = '2015-09-20 1.00 (takahiro)'

import sys
import optparse

usage = "%prog <days num> [filename]"
parser = optparse.OptionParser(usage=usage)
#parser.add_option('-n', '--name', dest='name', help='Your Name')
(options, args) = parser.parse_args()

if len(sys.argv) == 2:
  stream = sys.stdin
elif len(sys.argv) == 3:
  stream = open(sys.argv[2], 'r')
else:
  parser.print_help()
  exit()

num = int(sys.argv[1])

sum = 0.0
n = 0
avg = 0.0
for line in stream:
  (id, value) = line.rstrip().split(' ')
  id = int(id)
  value = float(value)
  sum += value
  n += 1

  if n == num:
    avg = sum/num
  elif n > num:
    avg = ((num-1) * avg + value) / num

  if n >= num:
    print id, avg

