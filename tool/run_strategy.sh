#!/bin/bash

# = run_strategy.sh
#
# Author::    takahiro
# Copyright:: takahiro
# License::   GPL
#

# == Version
#
# * 2015-08-20 1.00 (takahiro) 
#

# == Summary
# 
# This file is for
#

# == Interface
#
# * input
# **
# * output
# **
#

# == Example
#

# == Description
#
# This file is for
#


function usage { 
  echo "usage : $0 [options] <strategy file>"
  echo
  echo "options :"
  echo "  -t total (default)"
  echo "  -y yearly"
  echo "  -m monthly"
  echo "  -d daily"
  echo "  -o over"
  echo "  -h help"
  echo
  echo "ex ) $0 ./strategies/hoge.sql"
  exit
}


TOTAL_FLAG=0
YEARLY_FLAG=0
MONTHLY_FLAG=0
DAILY_FLAG=0
OVER_FLAG=0

while getopts "tymdoh" options
do
  case $options in
    t     ) TOTAL_FLAG=1;;
    y     ) YEARLY_FLAG=1;;
    m     ) MONTHLY_FLAG=1;;
    d     ) DAILY_FLAG=1;;
    o     ) OVER_FLAG=1;;
    h | * ) usage ;;
  esac
done
shift $(($OPTIND - 1))

if [ $YEARLY_FLAG -eq 0 -a $MONTHLY_FLAG -eq 0 -a \
     $DAILY_FLAG -eq 0 -a $OVER_FLAG -eq 0 ]; then
  TOTAL_FLAG=1
fi


if [ $# -ne 1 ]; then
  usage
fi

file=$1

if [ $OVER_FLAG -eq 1 ]; then
  TOTAL_FLAG=0
  YEARLY_FLAG=0
  MONTHLY_FLAG=0
  DAILY_FLAG=0
fi

function insert_field {
  echo "
  select t2.id entry_id,
         t3.id leave_id,
         t2.date entry_date,
         t3.date leave_date,
"
  cat $1 | sed -e '1,1d'
}

function pf_field {
  echo "
         count(*) count,
         sum(value) sum,
         sum(
           case
             when value>0
               then value
               else 0
           end
         ) positive,
         sum(
           case
             when value>0
               then 1
               else 0
           end
         ) positive_count,
         sum(
           case
             when value<0
               then value
               else 0
           end
         ) negative,
         sum(
           case
             when value<0
               then 1
               else 0
           end
         ) negative_count,
         max(value) max,
         min(value) min
"
}

function result_field {
  echo "
       tbl.sum s,
       abs(tbl.positive)/abs(tbl.negative) pf,
       tbl.sum*100-tbl.count*100 p_w_fee,
       tbl.count c,
       tbl.positive p,
       tbl.negative n,
       tbl.max max,
       tbl.min min,
       tbl.positive_count pc,
       tbl.negative_count nc,
       tbl.positive/tbl.positive_count p_pc,
       tbl.negative/tbl.negative_count n_nc,
       tbl.positive_count/tbl.count*100 pp,
       tbl.negative_count/tbl.count*100 np
"
}

function output_total {
  mysql -u $USER << EOD
use system_trade;
select
  $(result_field)
from (
  select
    $(pf_field)
  from (
    $(insert_field $file)
  ) t
) tbl
\G
;
EOD

  echo

  win_lose=$(output_daily \
    | sed -e '1,1d' \
    | cut -f2 \
    | ./tool/count_win_lose_in_a_row.py)
  win_num=$(echo $win_lose | cut -d' ' -f1)
  lose_num=$(echo $win_lose | cut -d' ' -f2)
  max_drawdown=$(echo $win_lose | cut -d' ' -f3)

  echo 'max_consecutive_win# ' $win_num
  echo 'max_consecutive_lose#' $lose_num
  echo 'max_drawdown         ' $max_drawdown
}

function output_yearly {
  mysql -u $USER << EOD
use system_trade;
select
  tbl.year,
  $(result_field)
from (
  select
    YEAR(t.entry_date) year,
    $(pf_field)
  from (
    $(insert_field $file)
  ) t
  group by YEAR(t.entry_date)
  order by YEAR(t.entry_date)
) tbl
;
EOD
}

function output_monthly {
  mysql -u $USER << EOD
use system_trade;
select
  tbl.year,
  tbl.month,
  $(result_field)
from (
  select
    YEAR(t.entry_date) year,
    MONTH(t.entry_date) month,
    $(pf_field)
  from (
    $(insert_field $file)
  ) t
  group by YEAR(t.entry_date),
           MONTH(t.entry_date)
  order by YEAR(t.entry_date),
           MONTH(t.entry_date)
) tbl
;
EOD
}

function output_daily {
  mysql -u $USER << EOD
use system_trade;
select
  tbl.date,
  $(result_field)
from (
  select
    t.entry_date date,
    $(pf_field)
  from (
    $(insert_field $file)
  ) t
  group by t.entry_date
  order by t.entry_date
) tbl
;
EOD
}

function output_over {
  mysql -u $USER << EOD
use system_trade;
select
  tbl.entry_date,
  tbl.entry_id,
  tbl.value,
  (
    select
      sum(tbl2.value)
    from (
      $(insert_field $file) 
    ) tbl2
    where
      tbl2.entry_date <= tbl.entry_date
  ) over
from (
  $(insert_field $file)
) tbl
order by tbl.entry_date
;
EOD
}

if [ $TOTAL_FLAG -eq 1 ]; then
  output_total | sed -e '1,1d'
  echo
fi

if [ $YEARLY_FLAG -eq 1 ]; then
  output_yearly
  echo
fi

if [ $MONTHLY_FLAG -eq 1 ]; then
  output_monthly
  echo
fi

if [ $DAILY_FLAG -eq 1 ]; then
  output_daily
  echo
fi

if [ $OVER_FLAG -eq 1 ]; then
  output_over | sed -e '1,1d' 
fi

