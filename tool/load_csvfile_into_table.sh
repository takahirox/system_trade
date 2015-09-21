#!/bin/bash

# = load_csvfile_into_table.sh
#
# Author::    takahiro
# Copyright:: takahiro
# License::   GPL
#

# == Version
#
# * 2015-09-20 1.00 (takahiro) 
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
  echo "usage : $0 <filename> <tablename>"
  echo "ex ) $0 nk225_daily.csv nk225_daily_table"
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


if [ $# -ne 2 ]; then
  usage
fi

FILE=$1
TABLE=$2

mysql -u $USER --local-infile << EOD
  use system_trade;
  load data local
    infile '$FILE' into table $TABLE
    columns terminated by ',';
EOD

