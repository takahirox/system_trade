#!/bin/bash

# = check_signal.sh
#
# Author::    takahiro
# Copyright:: takahiro
# License::   GPL
#

# == Version
#
# * 2015-08-29 1.00 (takahiro) 
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
  echo "ex ) $0 ./strategies/buy.sql"
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

. ./tool/extract_strategy_parameter.sh $file

function run_query {
  mysql -u $USER << EOD | tail -1
  use system_trade;
  select count(*)
  $(cat $file)
    and t.id=(select max(id)-$1 from ${table})
  ;
EOD
}

entry_flag=$(run_query $(($entry_from_trigger-1)))
leave_flag=$(run_query $(($entry_from_trigger+$leave_from_entry-1)))

echo $entry_flag - $leave_flag

