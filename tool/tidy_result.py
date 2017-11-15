#!/usr/bin/python

"""tidy_result.py

this script is
"""

__author__ = 'takahiro'
__version__ = '2015-08-25 1.00 (takahiro)'

import sys
import optparse
import math

usage = "%prog [options] [filename]"
parser = optparse.OptionParser(usage=usage)
parser.add_option('-t', '--total', dest='total', action='store_true',
                  help='total (default)')
parser.add_option('-y', '--yearly', dest='yearly', action='store_true',
                  help='yearly')
parser.add_option('-m', '--monthly', dest='monthly', action='store_true',
                  help='monthly')
parser.add_option('-d', '--daily', dest='daily', action='store_true',
                  help='daily')
parser.add_option('-o', '--over', dest='over', action='store_true',
                  help='over')
(options, args) = parser.parse_args()

if not options.yearly and \
   not options.monthly and \
   not options.daily and \
   not options.over:
  options.total = True


if len(args) == 0:
  stream = sys.stdin
elif len(args) == 1:
  stream = open(args[0], 'r')
else:
  parser.print_help()
  exit()


keys = ['sum', 'p_sum',
        'pf', 'p_pf',
        'p_w_fee', 'c',
        'pc', 'nc',
        'pp', 'np',
        'max_dd', 'p_max_dd',
        'max_s_wins', 'max_s_loses',
        'average', 'p_average',
        'deviation', 'p_deviation',
        'p', 'p_p',
        'n', 'p_n',
        'max', 'p_max',
        'min', 'p_min',
        'p_pc', 'p_p_pc',
        'n_pc', 'p_n_pc']


def init_p():
  p = {}
  p['sum'] = 0.0
  p['p'] = 0.0
  p['n'] = 0.0
  p['c'] = 0
  p['pc'] = 0
  p['nc'] = 0
  p['max'] = 0.0
  p['min'] = 0.0
  p['max_dd'] = 0.0
  p['p_sum'] = 0.0
  p['p_p'] = 0.0
  p['p_n'] = 0.0
  p['p_max'] = 0.0
  p['p_min'] = 0.0
  p['p_max_dd'] = 0.0
  p['max_s_wins'] = 0
  p['max_s_loses'] = 0
  # for work
  p['max_sum'] = 0.0
  p['p_max_sum'] = 0.0
  p['suc_wins'] = 0
  p['suc_loses'] = 0
  p['values'] = []
  p['p_values'] = []
  return p


def add_value(p, value, p_value):
  p['c'] += 1
  p['sum'] += value
  p['p_sum'] += p_value
  p['values'].append(value)
  p['p_values'].append(p_value)
  if value > 0.0:
    p['p'] += value
    p['p_p'] += p_value
    p['pc'] += 1
    p['suc_wins'] += 1
    p['suc_loses'] = 0
  if value <= 0.0:
    p['n'] += value
    p['p_n'] += p_value
    p['nc'] += 1
    p['suc_loses'] += 1
    p['suc_wins'] = 0
  if value > p['max']:
    p['max'] = value
  if value < p['min']:
    p['min'] = value
  if p_value > p['p_max']:
    p['p_max'] = p_value
  if p_value < p['p_min']:
    p['p_min'] = p_value
  if p['sum'] > p['max_sum']:
    p['max_sum'] = p['sum']
  if p['sum'] - p['max_sum'] < p['max_dd']:
    p['max_dd'] = p['sum'] - p['max_sum']
  if p['p_sum'] > p['p_max_sum']:
    p['p_max_sum'] = p['p_sum']
  if p['p_sum'] - p['p_max_sum'] < p['p_max_dd']:
    p['p_max_dd'] = p['p_sum'] - p['p_max_sum']
  if p['suc_wins'] > p['max_s_wins']:
    p['max_s_wins'] = p['suc_wins']
  if p['suc_loses'] > p['max_s_loses']:
    p['max_s_loses'] = p['suc_loses']


def get_unit():
  if options.market == 'usdjpy_daily':
    return 25000
  return 100


def get_fee():
  if options.market == 'usdjpy_daily':
    return 400
  return 100


def calc_value(p):
  p['p_w_fee'] = p['sum'] * get_unit() - p['c'] * get_fee()

  if p['n'] == 0.0:
    p['pf'] = float('inf')
  else:
    p['pf'] = p['p'] / -p['n']

  if p['p_n'] == 0.0:
    p['p_pf'] = float('inf')
  else:
    p['p_pf'] = p['p_p'] / -p['p_n']

  if p['pc'] == 0:
    p['p_pc'] = float('inf')
    p['p_p_pc'] = float('inf')
  else:
    p['p_pc'] = p['p'] / p['pc']
    p['p_p_pc'] = p['p_p'] / p['pc']

  if p['nc'] == 0:
    p['n_pc'] = float('inf')
    p['p_n_pc'] = float('inf')
  else:
    p['n_pc'] = p['n'] / p['nc']
    p['p_n_pc'] = p['p_n'] / p['nc']

  if p['c'] == 0:
    p['pp'] = float('inf')
    p['np'] = float('inf')
    p['average'] = 0
    p['deviation'] = 0.0
    p['p_average'] = 0.0
    p['p_deviation'] = 0.0
  else:
    p['pp'] = float(p['pc']) / float(p['c']) * 100.0
    p['np'] = float(p['nc']) / float(p['c']) * 100.0

    ave = float(p['sum']) / float(p['c'])
    s = 0.0

    for v in p['values']:
      s += pow(v - ave, 2)

    p['average'] = ave
    p['deviation'] = math.sqrt(s / p['c'])

    ave = float(p['p_sum']) / float(p['c'])
    s = 0.0

    for v in p['p_values']:
      s += pow(v - ave, 2)

    p['p_average'] = ave * 100.0
    p['p_deviation'] = math.sqrt(s / p['c']) * 100.0

  p['p_sum'] *= 100.0
  p['p_max_dd'] *= 100.0
  p['p_p'] *= 100.0
  p['p_n'] *= 100.0
  p['p_max'] *= 100.0
  p['p_min'] *= 100.0
  p['p_p_pc'] *= 100.0
  p['p_n_pc'] *= 100.0

def display_header():
  for k in keys:
    print '%12s' % k ,
  print


def display_p(p):
  for k in keys:
    print '%12.2f' % p[k] ,
  print


def display_p2(p):
  i = 0
  for k in keys:
    print '%12s : %12.2f' % (k, p[k]),
    if i % 2 == 1:
      print
    i += 1


total_p = init_p()
years_p = {}
months_p = {}
dates_p = {}
over = []

for line in stream:
  (d, value, p_value) = line.rstrip().split(' ')
  (year, month, date) = d.split('-')

  year = int(year)
  month = int(month)
  date = int(date)
  value = float(value)
  p_value = float(p_value)

  if not years_p.has_key(year):
    years_p[year] = init_p()
    months_p[year] = {}
    dates_p[year] = {}

  if not months_p[year].has_key(month):
    months_p[year][month] = init_p()
    dates_p[year][month] = {}

  if not dates_p[year][month].has_key(date):
    dates_p[year][month][date] = init_p()

  add_value(total_p, value, p_value)
  add_value(years_p[year], value, p_value)
  add_value(months_p[year][month], value, p_value)
  add_value(dates_p[year][month][date], value, p_value)
  over.append({'date': d, 'value': value, 'over': total_p['sum']})


if options.total:
  calc_value(total_p)
#  display_header()
#  display_p(total_p)
  display_p2(total_p)

if options.yearly:
  print '%12s' % ('year') ,
  display_header()
  for k, v in sorted(years_p.items()):
    print '%12d' % (k) ,
    calc_value(v)
    display_p(v)

if options.monthly:
  print '%12s %12s' % ('year', 'month') ,
  display_header()
  for k, v in sorted(months_p.items()):
    for k2, v2 in sorted(v.items()):
      print '%12d %12d' % (k, k2) ,
      calc_value(v2)
      display_p(v2)

if options.daily:
  print '%12s %12s %12s' % ('year', 'month', 'date') ,
  display_header()
  for k, v in sorted(dates_p.items()):
    for k2, v2 in sorted(v.items()):
      for k3, v3 in sorted(v2.items()):
        print '%12d %12d %12d' % (k, k2, k3) ,
        calc_value(v3)
        display_p(v3)

if options.over:
  for v in over:
    print '%s\t%12.2f\t%12.2f' % (v['date'], v['value'], v['over'])

