#!/bin/bash

# = run_daily.sh
#
# Author::    takahiro
# Copyright:: takahiro
# License::   GPL
#

# == Version
#
# * 2015-09-16 1.00 (takahiro) 
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

# this script is expected to be run with crontab
export USER=$(whoami)
. /home/${USER}/.profile

WAKEUP_AT="14:45" # 06:45 JPT
MAILTO="fujitv@gachapin.jp"
MAILSUBJECT="$(date) system_trade"

cd $(dirname $0)/..

./tool/init_data.sh
./tool/init.sh

./tool/check_signals.sh > .tmp
echo >> .tmp

ls -ltrF ./raw_data/*/*/*.csv | tail >> .tmp
echo >> .tmp

for file in $(find ./raw_data -type f)
do
  echo $(wc -l < $file) $(basename $file) >> .tmp
done

cat .tmp | mail -s "$MAILSUBJECT" $MAILTO

rm -f .tmp

./tool/wakeup_at.sh $WAKEUP_AT

cd -

