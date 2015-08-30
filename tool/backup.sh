#!/bin/bash

# = backup.sh
#
# Author::    takahiro
# Copyright:: takahiro
# License::   GPL
#

# == Version
#
# * 2015-08-30 1.00 (takahiro) 
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

rawdir=./raw_data
strategydir=./strategies
backupdir=./backup

if [ ! -e $backupdir ]; then
  mkdir -p $backupdir
  echo [log] $backupdir directory was generated.
fi

if [ ! -e $rawdir ]; then
  echo [log] no $rawdir directory.
  exit
fi

if [ ! -e $strategydir ]; then
  echo [log] no $strategydir directory.
  exit
fi


filename=${backupdir}/$(date "+%Y%m%d").tgz

tar -cvzf $filename ${rawdir} ${strategydir}

echo [log] $filename was generated.

