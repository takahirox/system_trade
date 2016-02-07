#!/bin/bash

# = show_equity_chart.sh
#
# Author::    takahiro
# Copyright:: takahiro
# License::   GPL
#

# == Version
#
# * 2015-08-21 1.00 (takahiro) 
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
  echo "usage : $0 <strategy file>"
  echo "ex ) $0 ./strategies/hoge.sql"
  exit
}


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


if [ $# -lt 1 ]; then
  usage
fi

datdir=./chart

if [ ! -e $datdir ]; then
  mkdir -p $datdir
  echo [log] $datdir directory was generated.
fi

function get_datfile_name {
  echo ${datdir}/$(basename $file .sql)_equity.dat
}

function get_imgfile_name {
  echo ${datdir}/$(basename $file .sql)_equity.png
}

function make_one_chart {
  file=$1
  flag=$2
  
  datfile=$(get_datfile_name $file)
  imgfile=$(get_imgfile_name $file)

  ./tool/run_strategy.sh -o $file | ./tool/tidy_dat.py > $datfile

  if [ $flag -eq 1 ]; then
    ./tool/make_equity_chart.sh $datfile $imgfile
  fi
}

if [ $# -eq 1 ]; then
  file=$1
  make_one_chart $file 1
else
  for file in $@
  do
    echo [log] making $file data
    make_one_chart $file 0
  done

  datfile=${datdir}/combine_equity.dat
  imgfile=${datdir}/combine_equity.png

  filenames=''

  echo -n > $datfile

  for file in $@
  do
    filenames+="$(get_datfile_name $file) "
  done

  cat $filenames | ./tool/tidy_dat.py > $datfile

  ./tool/make_equity_chart.sh $datfile $imgfile

fi

