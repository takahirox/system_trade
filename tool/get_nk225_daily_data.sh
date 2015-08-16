#!/bin/bash

# = get_nk225_daily_data.sh
#
# Author::    takahiro
# Copyright:: takahiro
# License::   GPL
#

# == Version
#
# * 2015-08-12 1.00 (takahiro) 
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

outdir=./raw_data/nk225/daily
logdir=./log/nk225/daily
url='http://k-db.com/indices/I101/a'
start=2007
end=2015
sleep_sec=3
file_prefix=$(basename $0 .sh)

if [ ! -e $outdir ]; then
  mkdir -p $outdir
  echo [log] $outdir directory was generated.
fi

if [ ! -e $logdir ]; then
  mkdir -p $logdir
  echo [log] $logdir directory was generated.
fi

for y in $(seq $start $end)
do
  echo [log] load $y
  wget -o $logdir/${file_prefix}_${y}.log \
       -O $outdir/${file_prefix}_${y}.csv \
       ${url}\?year=${y}\&download=csv
  echo [log] load $y done
  if [ "$y" -ne "$end" ]; then
    echo [log] sleep $sleep_sec sec for the server.
    sleep $sleep_sec
  fi
done

