#!/bin/bash

# = wakeup_at.sh
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


function usage { 
  echo "usage : $0 <HH:MM>"
  echo "ex ) $0 07:30"
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

DESIRED=$(date +%s -d $1)
NOW=$(date +%s)

if [ $DESIRED -lt $NOW ]; then
  DESIRED=$(($DESIRED + 24*60*60))
fi

SEC=$(($DESIRED - $NOW))

#sudo killall rtcwake
sudo rtcwake -l -m no -s $SEC

cat /proc/driver/rtc

