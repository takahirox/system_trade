#!/bin/bash

# = add_latest_dji_daily_data.sh
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

in_file=./raw_data/dji/daily/get_latest_dji_daily_data.json
out_file=./raw_data/dji/daily/get_dji_daily_data.csv
tmp_file=.tmp

head -1 $out_file > $tmp_file
./tool/make_latest_dji_daily_csv.py $in_file >> $tmp_file
cat $out_file | sed -e "1,1d" >> $tmp_file

./tool/uniq_dji_daily.py $tmp_file > $out_file

rm -f $tmp_file

