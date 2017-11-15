#!/bin/bash

# = check_out_of_deviation.sh
#
# Author::    takahiro
# Copyright:: takahiro
# License::   GPL
#

# == Version
#
# * 2017-11-15 1.00 (takahiro) 
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

p_ave=$(./tool/run_strategy.sh $@ | grep p_average | awk '{print $6}')
p_dev=$(./tool/run_strategy.sh $@ | grep p_deviation | awk '{print $6}')

count=0
p_count=0
n_count=0

p_bound=$(echo "$p_ave+$p_dev*2.0" | bc)
n_bound=$(echo "$p_ave-$p_dev*2.0" | bc)

for value in $(./tool/run_strategy.sh -l $@ | awk '{print $3}'); do
  value=$(echo "$value*100.0" | bc)
  if [ $(echo "$value>$p_bound" | bc) -eq 1 ]; then
    p_count=$((p_count+1))
  fi
  if [ $(echo "$value<$n_bound" | bc) -eq 1 ]; then
    n_count=$((n_count+1))
  fi
  count=$((count+1))
done

all_count=$((p_count+n_count))

echo "count: $count"
echo "p_average: $p_ave"
echo "p_deviation: $p_dev"
echo "over p_ave+2p_dev: $p_count ($(echo "scale=2; $p_count/$count*100.0" | bc -l)%)"
echo "over p_ave-2p_dev: $n_count ($(echo "scale=2; $n_count/$count*100.0" | bc -l)%)"
echo "over p_ave+-2p_dev: $all_count ($(echo "scale=2; $all_count/$count*100.0" | bc -l)%)"
