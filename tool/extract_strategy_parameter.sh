#!/bin/bash

# = extract_strategy_parameter.sh
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
  echo "usage : $0 <strategy file>"
  echo "ex ) $0 ./strategies/sample.sql"
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

table=$(cat $file \
        | egrep -- '^-- table=' \
        | cut -d= -f2)
entry_from_trigger=$(cat $file \
                     | egrep -- '^-- entry_from_trigger=' \
                     | cut -d= -f2)
leave_from_entry=$(cat $file \
                   | egrep -- '^-- leave_from_entry=' \
                   | cut -d= -f2)
entry_time=$(cat $file \
             | egrep -- '^-- entry_time=' \
             | cut -d= -f2)
leave_time=$(cat $file \
             | egrep -- '^-- leave_time=' \
             | cut -d= -f2)
is_buy=$(cat $file \
         | egrep -- '^-- is_buy=' \
         | cut -d= -f2)

