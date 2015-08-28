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
  echo "
  select t1.id triger_id,
         t2.id entry_id,
         t3.id leave_id,
         t1.date triger_date,
         t2.date entry_date,
         t3.date leave_date,
         0 is_losscut,
"
  cat $1 \
    | perl -pe "s/^\s*--.*$//g" \
    | perl -pe "s/\n/ /g" \
    | perl -pe "s/select//" \
    | perl -pe "s/;.*$//g" 

  if [ "$FROM_DATE" != "" -a "$TO_DATE" = "" ]; then
    echo "and t1.date>=\"${FROM_DATE}\""
  elif [ "$FROM_DATE" = "" -a "$TO_DATE" != "" ]; then
    echo "and t1.date<=\"${TO_DATE}\""
  elif [ "$FROM_DATE" != "" -a "$TO_DATE" != "" ]; then
    echo "and t1.date>=\"${FROM_DATE}\" and t1.date<=\"${TO_DATE}\""
  fi

  echo "
  order by t1.id;
"
}

# output_sql $file

mysql -u $USER << EOD > .tmp
use system_trade;
$(output_sql $file)
EOD

cat .tmp \
  | sed "1,1d" \
  | ./tool/extract_result.py \
  | ./tool/tidy_result.py $OPTIONS

rm -f .tmp

