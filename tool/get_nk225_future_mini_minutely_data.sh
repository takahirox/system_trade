#!/bin/bash

# = get_nk225_future_mini_minutely_data.sh
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

outdir=./raw_data/nk225_future_mini/minutely
logdir=./log/nk225_future_mini/minutely
url="http://k-db.com/futures/F102-0000/5m"
file_prefix=$(basename $0 .sh)

if [ ! -e $outdir ]; then
  mkdir -p $outdir
  echo [log] $outdir directory was generated.
fi

if [ ! -e $logdir ]; then
  mkdir -p $logdir
  echo [log] $logdir directory was generated.
fi

echo [log] $file_prefix $d start.

wget --user-agent="" -o .tmp_log -O .tmp_file $url\?download=csv
d=$(iconv -f SHIFT-JIS -t UTF-8 .tmp_file | tail -1 | cut -d, -f1)

mv .tmp_log ${logdir}/${file_prefix}_${d}.log
mv .tmp_file ${outdir}/${file_prefix}_${d}.csv

echo [log] $file_prefix $d done.

