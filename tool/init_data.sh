#!/bin/bash

# = init_data.sh
#
# Author::    takahiro
# Copyright:: takahiro
# License::   GPL
#

# == Version
#
# * 2015-08-15 1.00 (takahiro) 
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

error_log_file=./log/init_data.log

./tool/init_dji_daily_data.sh 2>$error_log_file
#./tool/init_dji_future_mini_daily_data.sh 2>$error_log_file
#./tool/init_nk225_daily_data.sh 2>$error_log_file
./tool/init_nk225_future_mini_daily_data.sh 2>$error_log_file
#./tool/init_nk225_future_mini_minutely_data.sh 2>$error_log_file
#./tool/init_topix_daily_data.sh 2>$error_log_file

#./tool/init_usdjpy_daily_data.sh

