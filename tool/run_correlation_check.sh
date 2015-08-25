#!/bin/bash

# = run_correlation_check.sh
#
# Author::    takahiro
# Copyright:: takahiro
# License::   GPL
#

# == Version
#
# * 2015-08-24 1.00 (takahiro) 
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
  echo "usage : $0 [options] <table1> <table2>"
  echo
  echo "options :"
  echo "  -t  total (default)"
  echo "  -y  yearly"
  echo "  -m  monthly"
  echo
  echo "ex ) $0 nk225_daily dji_daily"
  exit
}

TOTAL_FLAG=0
YEARLY_FLAG=0
MONTHLY_FLAG=0

while getopts "tym" options
do
  case $options in
    t     ) TOTAL_FLAG=1;;
    y     ) YEARLY_FLAG=1;;
    m     ) MONTHLY_FLAG=1;;
    h | * ) usage ;;
  esac
done
shift $(($OPTIND - 1))

if [ $YEARLY_FLAG -eq 0 -a $MONTHLY_FLAG -eq 0 ]; then
  TOTAL_FLAG=1
fi


if [ $# -ne 2 ]; then
  usage
fi

table1=$1
table2=$2

function get_sql {
cat ./sqls/correlation.sql \
  | sed -e "s/%%table1%%/${table1}/g" \
  | sed -e "s/%%table2%%/${table2}/g"
}

mysql -u $USER << EOD
use system_trade;
$(
  if [ $TOTAL_FLAG -eq 1 ]; then 
    get_sql
  fi
)
$(
  if [ $YEARLY_FLAG -eq 1 ]; then
    get_sql | sed -e 's/-- y//g'
  fi
)
$(
  if [ $MONTHLY_FLAG -eq 1 ]; then
    get_sql | sed -e 's/-- y//g' | sed -e 's/-- m//g'
  fi
)
EOD

