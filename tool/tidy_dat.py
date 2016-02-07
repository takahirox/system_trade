#!/usr/bin/python

"""tidy_dat.py

this script is
"""

__author__ = 'takahiro'
__version__ = '2016-02-06 1.00 (takahiro)'

import sys
#import optparse
import re

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

re_any_blanks = re.compile(r'\s+')
lines = []
for line in stream:
  values = re_any_blanks.split(line.rstrip())
  lines.append(values)

lines.sort(key=lambda x:x[0])
lines.append([None, 0, 0])

sum = 0
max_sum = sum
max_drawdown = 0
max_win_r = 0
max_lose_r = 0
win_r = 0
lose_r = 0
pre_date = None
value = 0
for line in lines:
  d = line[0]
  v = float(line[1])
  s = float(line[2])

  if d == pre_date:
    value += v
  else:
    sum += value
    if sum > max_sum:
      max_sum = sum

    drawdown = -(max_sum - sum)
    if drawdown  < max_drawdown:
      max_drawdown = drawdown

    if value > 0:
      win_r += 1
      lose_r = 0
    elif value < 0:
      win_r = 0
      lose_r += 1

    if win_r > max_win_r:
      max_win_r = win_r

    if lose_r > max_lose_r:
      max_lose_r = lose_r

    if pre_date != None:
      print '%s\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\t%d\t%d' % (pre_date, value, sum, max_sum, drawdown, max_drawdown, max_win_r, max_lose_r)
    value = v

  pre_date = d

