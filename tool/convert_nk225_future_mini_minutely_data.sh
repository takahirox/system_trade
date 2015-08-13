#!/bin/bash

# = convert_nk225_future_mini_minutely_data.sh
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

indir=./raw_data/nk225_future_mini/minutely
outdir=./csv_data/nk225_future_mini/minutely

if [ ! -e $indir ]; then
  echo [error] no $indir directory.
  exit
fi

if [ ! -e $outdir ]; then
  mkdir -p $outdir
  echo [log] $outdir was generated.
fi

for file in $(ls ${indir}/*.csv)
do
  outfile=$(basename $file)
  iconv -f SHIFT-JIS -t UTF-8 $file \
    | sed -e "1,2d" \
    > ${outdir}/${outfile}
  echo [log] ${outdir}/${outfile} was generated
done

