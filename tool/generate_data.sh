#!/bin/bash

# = generate_data.sh
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

function show_tables {
  mysql -u $USER <<EOD \
      | sed "1,1d" \
      | grep -v _master \
      | grep -v _tmp \
      | grep -v _minutely
    use system_trade;
    show tables;
EOD
}


function run_query {
  template_file=$1
  table1=$2
  table2=$3

  echo [log] $table1 table data generation.
  mysql -u $USER <<EOD
    use system_trade;
    $(cat $template_file \
       | perl -pe "s/%%TABLE%%/$table1/g" \
       | perl -pe "s/%%TABLE2%%/$table2/g")
EOD
}


for table in $(show_tables | grep _daily)
do
  if [ "$table" = "nk225_daily" -o "$table" = "topix_daily" ]; then
    template_file=./sqls/generate_basic_data1.sql.template
    table1=$table
    table2=""
  elif [ "$table" = "dji_daily" -o "$table" = "dji_future_mini_daily" -o "$table" = "usdjpy_daily" ]; then
    template_file=./sqls/generate_basic_data2.sql.template
    table1=$table
    table2=""
  elif [ "$table" = "nk225_future_mini_daily" ]; then
    template_file=./sqls/generate_basic_data3.sql.template
    table1=$table
    table2=""
  elif [ "$table" = "nk225_future_mini_daily_with_night" ]; then
    template_file=./sqls/generate_basic_data4.sql.template
    table1=$table
    table2=$(echo $table | sed -e "s/_with_night//g")
  else
    echo [error] $table file exception.
    exit
  fi
  run_query $template_file $table1 $table2
done


for table in $(show_tables | grep _weekly)
do
  template_file=./sqls/generate_basic_weekly_data.sql.template
  table1=$table
  table2=$(echo $table | sed -e "s/_weekly/_daily/g")
  run_query $template_file $table1 $table2
done


for table in $(show_tables | grep _monthly)
do
  template_file=./sqls/generate_basic_monthly_data.sql.template
  table1=$table
  table2=$(echo $table | sed -e "s/_monthly/_daily/g")
  run_query $template_file $table1 $table2
done


for table in $(show_tables)
do
  run_query ./sqls/generate_data.sql.template $table ""
done

