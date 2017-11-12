#!/bin/bash

# = make_equity_chart.sh
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
  echo "usage : $0 [option] <input dat file> <output img file>"
  echo
  echo "options:"
  echo "  -n : disable image display"
  echo "  -h : show this help"
  echo
  echo "ex ) $0 -n ./chart/hoge.dat ./chart/hoge.png"
  exit
}

DISABLE_IMAGE_DISPLAY=0
while getopts "nh" options
do
  case $options in
    n     ) DISABLE_IMAGE_DISPLAY=1;;
    h | * ) usage ;;
  esac
done
shift $(($OPTIND - 1))


if [ $# -ne 2 ]; then
  usage
fi

datfile=$1
imgfile=$2

gnuplot -p << EOD
set datafile separator "\t"
set xdata time
set timefmt "%Y-%m-%d"
set format x "%Y-%m-%d"
toffset=strptime("%Y-%m-%d", "2007-01-01")
f(x)=a*(x-toffset)+b
fit f(x) "${datfile}" u 1:3 via a,b
set xtics rotate by 270
set term png
set output "${imgfile}"
plot "${datfile}" u 1:3 w l, f(x)
set output
EOD

if [ $DISABLE_IMAGE_DISPLAY -eq 0 ]; then
  display $imgfile &
fi

