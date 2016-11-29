#!/bin/bash

# = get_latest_dji_daily_data.sh
#
# Author::    takahiro
# Copyright:: takahiro
# License::   GPL
#

# == Version
#
# * 2016-11-28 1.00 (takahiro) 
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
url="http://query1.finance.yahoo.com/v8/finance/chart/%5EDJI?interval=1d&region=US"
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
     -O $outdir/${file_prefix}.json \
     ${url}
echo [log] load $file_prefix done

