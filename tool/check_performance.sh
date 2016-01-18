#!/bin/bash

# = check_performance.sh
#
# Author::    takahiro
# Copyright:: takahiro
# License::   GPL
#

# == Version
#
# * 2016-01-17 1.00 (takahiro) 
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


# function usage { 
#   echo "usage : $0 <HOGE>"
#   echo "ex ) $0 HOGE"
#   exit
# }
#

# while getopts "abd:h" options
# do
#   case $options in
#     a | b ) ;;
#     d     ) OPTDATA=${OPTARG} ;;
#     h | * ) usage ;;
#   esac
# done
# shift $(($OPTIND - 1))
#


# if [ $# -ne 1 ]; then
#   usage
# fi
#
# HOGE=$1
#

startyear=2007
thisyear=$(date "+%Y")

echo [log] annual performance

for y in $(seq $startyear $thisyear)
do
  echo $y
  ./tool/confirm_strategies.sh -f $y-01-01 -t $y-12-31 | grep p_w_fee | awk '{s+=$3} END {print s}'

  echo

done

echo [log] term performances

for y in $(seq $startyear $thisyear)
do
  echo $y -
  ./tool/confirm_strategies.sh -f $y-01-01
done

for y in $(seq $startyear $thisyear)
do
  echo - $y
  ./tool/confirm_strategies.sh -t $y-12-31
done

