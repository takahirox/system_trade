#!/bin/bash

# = show_wave.sh
#
# Author::    takahiro
# Copyright:: takahiro
# License::   GPL
#

# == Version
#
# * 2015-08-26 1.00 (takahiro) 
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
  echo "usage : $0 <date> <range> [table]"
  echo
  echo "[table] default is nk225_future_mini_daily"
  echo
  echo "ex ) $0 2015-08-11 10 nk225_daily"
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


if [ $# -eq 2 ]; then
  table="nk225_future_mini_daily"
elif [ $# -eq 3 ]; then
  table=$3
else
  usage
fi

date=$1
range=$2

datdir=./chart
filename=${datdir}/${date}_${range}_${table}
datfile=${filename}.dat
imgfile=${filename}.png

mysql -u $USER << EOD | sed "1,1d" > $datfile
use system_trade;
select date,
       open,
       high,
       low,
       close,
       ma5,
       ma25,
       ma75
from ${table}
where id between
           (select id from $table where date="${date}") - $range
         and
           (select id from $table where date="${date}") + $range
order by date;
EOD

gnuplot -p << EOD
set xtics rotate by 270
set term png
set output "${imgfile}"
plot \
  "${datfile}" u (\$0):2:3:4:5:xtic(1) w candlesticks title "candle", \
  "" u (\$0):6 w l title "MA5", \
  "" u (\$0):7 w l title "MA25", \
  "" u (\$0):8 w l title "MA75"
set output
EOD

display $imgfile &

