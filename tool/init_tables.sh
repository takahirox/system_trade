#!/bin/bash

# = init_tables.sh
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

mysql -u $USER < ./sqls/create_master_tables.sql

function run_query {
  mysql -u $USER <<EOD
    use system_trade;
    $(perl -pe "s/%%TABLE%%/${1}/g" \
                ./sqls/create_table.sql.template)
EOD

}

for table in $(grep 'create table' ./sqls/create_master_tables.sql \
                | awk '{print $3}')
do
  table=$(echo $table | sed -e "s/_master//g")

  if [ $(echo $table | grep -c daily) -ne 0 ]; then
    for suffix in daily weekly monthly
    do
      t=$(echo $table | sed "s/_daily/_${suffix}/g")
      run_query $t
      if [ "$table" = "nk225_future_mini_daily" ]; then
        t+="_with_night"
        run_query $t
      fi
    done
  fi
done

mysql -u $USER <<EOD
  use system_trade;
  show tables;
EOD


