#!/bin/bash

# = show_non_break_date.sh
#
# Author::    takahiro
# Copyright:: takahiro
# License::   GPL
#

# == Version
#
# * 2017-11-11 1.00 (takahiro) 
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
  echo "usage : $0 <equity chart data>"
  echo "ex ) $0 ./chart/combine_equity.dat"
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

FILE=$1

gnuplot <<EOD
set datafile separator "\t"
set xdata time
set timefmt "%Y-%m-%d"
set xtics rotate by 270
set term png
set output ".tmp.png"
plot "$FILE" u 1:9 w l
set output
EOD

display .tmp.png &

