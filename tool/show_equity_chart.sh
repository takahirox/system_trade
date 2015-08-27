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


if [ $# -ne 1 ]; then
  usage
fi

file=$1
datdir=./chart
datfile=${datdir}/$(basename $file .sql)_equity.dat
imgfile=${datdir}/$(basename $file .sql)_equity.png

if [ ! -e $datdir ]; then
  mkdir -p $datdir
  echo [log] $datdir directory was generated.
fi

./tool/run_strategy.sh -o $file > $datfile

gnuplot -p << EOD
set xtics rotate by 270
set xdata time
set timefmt "%Y-%m-%d"
set datafile separator "\t"
set term png
set output "${imgfile}"
plot "${datfile}" u 1:3 w l
set output
EOD

display $imgfile &
