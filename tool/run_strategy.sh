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
  echo "  -s summary (default)"
  echo "  -y yearly"
  echo "  -m monthly"
  echo "  -d daily"
  echo "  -o over"
  echo "  -f <date> from"
  echo "  -t <date> to"
  echo "  -h help"
  echo
  echo "ex ) $0 ./strategies/hoge.sql"
  exit
}


SUMMARY_FLAG=0
YEARLY_FLAG=0
MONTHLY_FLAG=0
DAILY_FLAG=0
OVER_FLAG=0
FROM_DATE=""
TO_DATE=""

while getopts "symdof:t:h" options
do
  case $options in
    s     ) SUMMARY_FLAG=1;;
    y     ) YEARLY_FLAG=1;;
    m     ) MONTHLY_FLAG=1;;
    d     ) DAILY_FLAG=1;;
    o     ) OVER_FLAG=1;;
    f     ) FROM_DATE=${OPTARG} ;;
    t     ) TO_DATE=${OPTARG} ;;
    h | * ) usage ;;
  esac
done
shift $(($OPTIND - 1))

if [ $# -ne 1 ]; then
  usage
fi


if [ $YEARLY_FLAG -eq 0 -a $MONTHLY_FLAG -eq 0 -a \
     $DAILY_FLAG -eq 0 -a $OVER_FLAG -eq 0 ]; then
  SUMMARY_FLAG=1
fi

OPTIONS=""

if [ $SUMMARY_FLAG -eq 1 ]; then
  OPTIONS+=" -t"
fi

if [ $YEARLY_FLAG -eq 1 ]; then
  OPTIONS+=" -y"
fi

if [ $MONTHLY_FLAG -eq 1 ]; then
  OPTIONS+=" -m"
fi

if [ $DAILY_FLAG -eq 1 ]; then
  OPTIONS+=" -d"
fi

if [ $OVER_FLAG -eq 1 ]; then
  OPTIONS+=" -o"
fi

file=$1

function output_sql {

  . ./tool/extract_strategy_parameter.sh $file

  echo "
  select tt1.id trigger_id,
         tt2.id entry_id,
         tt3.id leave_id,
         tt1.date triger_date,
         tt2.date entry_date,
         tt3.date leave_date,
         0 is_losscut,
         tt1.close trigger_value,
         tt2.${entry_time} entry_value,
         tt3.${leave_time} leave_value,
         ${is_buy} is_buy
  from (
    select t.id,
           t.date
"

  cat $file | perl -pe "s/^\s*--.*$//g"

  echo "
  ) tt,
    ${table} tt1,
    ${table} tt2,
    ${table} tt3
  where tt1.id=tt.id
    and tt2.id=tt1.id+${entry_from_trigger}
    and tt3.id=tt2.id+${leave_from_entry}
  "

  if [ "$FROM_DATE" != "" ]; then
    echo "and tt1.date>=\"${FROM_DATE}\""
  fi

  if [ "$TO_DATE" != "" ]; then
    echo "and tt1.date<=\"${TO_DATE}\""
  fi

  echo "
  order by tt1.id;
"
}

# output_sql # for debug

mysql -u $USER << EOD > .tmp
use system_trade;
$(output_sql)
EOD

cat .tmp \
  | sed "1,1d" \
  | ./tool/extract_result.py \
  | ./tool/tidy_result.py $OPTIONS

rm -f .tmp

