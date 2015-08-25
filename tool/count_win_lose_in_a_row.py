#!/usr/bin/python

"""count_win_lose_in_a_row.py

this script is
"""

__author__ = 'takahiro'
__version__ = '2015-08-23 1.00 (takahiro)'

import sys
#import optparse

#usage = "%prog [options] [filename]"
#parser = optparse.OptionParser(usage=usage)
#(options, args) = parser.parse_args()

if len(sys.argv) == 1:
  stream = sys.stdin
elif len(sys.argv) == 2:
  stream = open(sys.argv[1], 'r')
else:
  parser.print_help()
  exit()

max_win = 0
max_lose = 0
count_win = 0
count_lose = 0
sum = 0.0
max_sum = 0.0
max_drawdown = 0.0

for line in stream:
  n = float(line)
  if n > 0.0:
    count_win += 1
    count_lose = 0
    if count_win > max_win:
      max_win = count_win
  if n < 0.0:
    count_win = 0
    count_lose += 1
    if count_lose > max_lose:
      max_lose = count_lose

  sum += n

  if sum > max_sum:
    max_sum = sum

  if sum - max_sum < max_drawdown:
    max_drawdown = sum - max_sum

print max_win, max_lose, max_drawdown


