#!/bin/bash

# = dapop.sh
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

indir=./csv_data/
nk225_future_mini_indir=./csv_data/nk225_future_mini

echo [log] nk225 future mini daily load start.
for file in $(ls ${nk225_future_mini_indir}/daily/*.csv)
do
  echo [log] $file load start.
  mysql -u takahiro --local-infile << EOD
    use system_trade;
    load data local
      infile '$file' into table nk225_future_mini_daily
      columns terminated by ',';
EOD
  echo [log] $file load end.
done
echo [log] nk225 future mini daily load end.

mysql -u takahiro << EOD
  use system_trade;
  select count(*) from nk225_future_mini_daily;
EOD


echo [log] nk225 future mini minitely load start.
for file in $(ls ${nk225_future_mini_indir}/minutely/*.csv)
do
  echo [log] $file load start.
  mysql -u takahiro --local-infile << EOD
    use system_trade;
    load data local
      infile '$file' into table nk225_future_mini_minutely
      columns terminated by ',';
EOD
  echo [log] $file load end.
done
echo [log] nk225 future mini minitely load end.

mysql -u takahiro << EOD
  use system_trade;
  select count(*) from nk225_future_mini_minutely;
EOD

