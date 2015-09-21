#!/bin/bash

# = dapop.sh
#
# Author::    $USER
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

indir=./csv_data/
nk225_indir=./csv_data/nk225
topix_indir=./csv_data/topix
nk225_future_mini_indir=./csv_data/nk225_future_mini
dji_indir=./csv_data/dji
usdjpy_indir=./csv_data/usdjpy


function run_query {
  echo [log] ${1} load start.
  for file in $(ls ${2}/*.csv)
  do
    echo [log] $file load start.
    ./tool/load_csvfile_into_table.sh $file ${1}_master
    echo [log] $file load end.
  done
  echo [log] ${1} load end.

  mysql -u $USER << EOD
    use system_trade;
    select count(*) from ${1}_master;
EOD
}


run_query nk225_daily ${nk225_indir}/daily
run_query topix_daily ${topix_indir}/daily
run_query nk225_future_mini_daily ${nk225_future_mini_indir}/daily
run_query nk225_future_mini_minutely ${nk225_future_mini_indir}/minutely
run_query dji_daily ${dji_indir}/daily
run_query usdjpy_daily ${usdjpy_indir}/daily

