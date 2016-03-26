#!/bin/bash

# = get_usdjpy_daily_data.sh
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

outdir=./raw_data/usdjpy/daily
logdir=./log/usdjpy/daily
url='http://www.m2j.co.jp/market/pchistry_dl.php?ccy=1&type=d'
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
     -o $logdir/${file_prefix}.log \
     -O $outdir/${file_prefix}.csv \
     ${url}
echo [log] load $file_prefix done

