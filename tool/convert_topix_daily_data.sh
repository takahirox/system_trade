#!/bin/bash

# = convert_topix_daily_data.sh
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

indir=./raw_data/topix/daily
outdir=./csv_data/topix/daily

if [ ! -e $indir ]; then
  echo [error] no $indir directory.
  exit
fi

if [ ! -e $outdir ]; then
  mkdir -p $outdir
  echo [log] $outdir directory was generated.
fi

for file in $(ls $indir/*.csv)
do
  out_file=$(basename $file .csv)
  iconv -f SHIFT-JIS -t UTF-8 $file \
    | perl -pe "s/前場/0/g" \
    | perl -pe "s/後場/1/g" \
    | sed -e "1,1d" \
    > ${outdir}/${out_file}.csv
  echo [log] ${outdir}/${out_file}.csv was generated.
done

