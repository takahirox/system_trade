#!/usr/bin/python

"""count_distribution.py

this script is
"""

__author__ = 'takahiro'
__version__ = '2017-11-10 1.00 (takahiro)'

import sys
import optparse

usage = "%prog [options] [filename]"
parser = optparse.OptionParser(usage=usage)
parser.add_option('-u', '--unit', dest='unit', help='unit range')
(options, args) = parser.parse_args()

if len(args) == 0:
  stream = sys.stdin
elif len(args) == 1:
  stream = open(args[0], 'r')
else:
  parser.print_help()
  exit()

if options.unit == None:
  unit = 100
else:
  unit = int(options.unit)

min = 0.0
max = 0.0
dist = {}

for line in stream:
  value = int(float(line.strip().split(' ')[2]) * 10000.0)
  value = int((value + (unit / 2)) / unit) * unit

  if not dist.has_key(value):
    dist[value] = 0

  dist[value] += 1

  if value < min:
    min = value
  if value > max:
    max = value

if -min < max:
  min = -max

if max < -min:
  max = -min

index = min

while index <= max:
  if dist.has_key(index):
    value = dist[index]
  else:
    value = 0

  print index, value

  index += unit

