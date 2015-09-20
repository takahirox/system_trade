#!/bin/bash

# = confirm_strategies.sh
#
# Author::    takahiro
# Copyright:: takahiro
# License::   GPL
#

# == Version
#
# * 2015-09-19 1.00 (takahiro) 
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
  echo "usage : $0 [optioons]"
  echo
  echo "options :"
  echo "  -f <date> from"
  echo "  -t <date> to"
  echo
  echo "ex ) $0 -f 2014-01-01"
  exit
}


FROM_DATE=""
TO_DATE=""

while getopts "f:t:h" options
do
  case $options in
    f     ) FROM_DATE=${OPTARG} ;;
    t     ) TO_DATE=${OPTARG} ;;
    h | * ) usage ;;
  esac
done
shift $(($OPTIND - 1))



# if [ $# -ne 1 ]; then
#   usage
# fi
#
# HOGE=$1
#

options=""

if [ "$FROM_DATE" != "" ]; then
  options+=" -f $FROM_DATE"
fi

if [ "$TO_DATE" != "" ]; then
  options+=" -t $TO_DATE"
fi

for file in $(ls ./strategies/run/*.sql)
do
  echo [log] $file
  ./tool/run_strategy.sh $options $file
  echo 
done

