#!/bin/bash

# = init.sh
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

function usage { 
  echo "usage : $0 [options]"
  echo
  echo "options :"
  echo "  -u update"
  echo "  -h show this help"
  echo
  echo "ex ) $0 -u"
  exit
}


UPDATE_FLAG=0
while getopts "uh" options
do
  case $options in
    u     ) UPDATE_FLAG=1 ;;
    h | * ) usage ;;
  esac
done
shift $(($OPTIND - 1))



# if [ $# -ne 1 ]; then
#   usage
# fi
#
# HOGE=$1
#

if [ $UPDATE_FLAG -eq 0 ]; then
  ./tool/init_database.sh
fi

# loading entire master data is not so heavy
# that it does that every day so far
./tool/init_master_tables.sh
./tool/dapop.sh

if [ $UPDATE_FLAG -eq 0 ]; then
  ./tool/init_tables.sh
fi

./tool/generate_data.sh
./tool/generate_adx.sh

