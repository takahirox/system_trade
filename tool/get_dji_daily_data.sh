#!/bin/bash

# = get_dji_daily_data.sh
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

outdir=./raw_data/dji/daily
logdir=./log/dji/daily
file_prefix=$(basename $0 .sh)

if [ ! -e $outdir ]; then
  mkdir -p $outdir
  echo [log] $outdir directory was generated.
fi

if [ ! -e $logdir ]; then
  mkdir -p $logdir
  echo [log] $logdir directory was generated.
fi

echo [log] load $file_prefix

wget --user-agent="" \
     --no-check-certificate \
     --save-cookies=cookie.txt \
     -o $logdir/get_crumb.log \
     -O crumb.store \
     "https://finance.yahoo.com/quote/%5EDJI/p=%5EDJI"

crumb=$(grep 'root.*App' crumb.store | \
        sed 's/,/\n/g' | \
        grep CrumbStore | \
        sed 's/"CrumbStore":{"crumb":"\(.*\)"}/\1/')

wget --user-agent="" \
     --no-check-certificate \
     --load-cookies=cookie.txt \
     -o $logdir/${file_prefix}.log \
     -O $outdir/${file_prefix}.csv \
     "https://query1.finance.yahoo.com/v7/finance/download/%5EDJI?period1=475833600&period2=99999999999&interval=1d&events=history&crumb=$crumb"

rm -f crumb.store cookie.txt

echo [log] load $file_prefix done

