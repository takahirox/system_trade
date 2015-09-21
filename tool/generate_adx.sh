#!/bin/bash

# = generate_adx.sh
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

N=14
TMP_TABLE=tmp_adx_work
TMP_FILE=.tmp.csv

function run_query {
  table=$1
  col=$2
  acol=$3

  echo [log] create $TMP_TABLE.
  mysql -u $USER <<EOD
    use system_trade;
    drop table if exists $TMP_TABLE;
    create table $TMP_TABLE (
      id int,
      val float(7,2)
    );
EOD

  echo [log] output $col into $TMP_FILE file.
  mysql -u $USER <<EOD \
      | sed "1,1d" \
      | awk '{print $1, $2}' \
      | ./tool/calculate_mma.py $N \
      | sed -e "s/ /,/g" > $TMP_FILE
    use system_trade;
    select id, $col from $table where $col is not NULL order by id;
EOD

  echo [log] load $TMP_FILE into $TMP_TABLE table.
  ./tool/load_csvfile_into_table.sh $TMP_FILE $TMP_TABLE

  echo [log] remove $TMP_FILE file.
  rm -f $TMP_FILE

  echo [log] update $acol.
  mysql -u $USER <<EOD
    use system_trade;
    update $table t1
      inner join (
        select t.id id,
               t.val val
        from $TMP_TABLE t
        order by t.id
      ) t2
      on t1.id=t2.id
      set t1.$acol=t2.val
EOD

  echo [log] drop $TMP_TABLE table.
  mysql -u $USER <<EOD
    use system_trade;
    drop table $TMP_TABLE;
EOD
}


function run_query_table {
  table=$1

  echo [log] generate dm and tr.
  mysql -u $USER <<EOD
    use system_trade;
    $(perl -pe "s/%%TABLE%%/$table/g" ./sqls/generate_dm_and_tr.sql.template)
EOD

  run_query $table dmp admp
  run_query $table dmn admn
  run_query $table tr atr

  echo [log] generate dx.
  mysql -u $USER <<EOD
    use system_trade;
    update $table t1
      inner join (
        select t.id id,
               t.admp/t.atr*100 dip,
               t.admn/t.atr*100 din
        from $table t
        order by t.id
      ) t2
      on t1.id=t2.id
      set t1.dip=t2.dip,
          t1.din=t2.din,
          t1.dx=abs(t2.dip-t2.din)/(t2.dip+t2.din)*100
EOD

  run_query $table dx adx
}


for table in $(
  mysql -u $USER <<EOD | sed "1,1d" | grep -v _master | grep -v tmp_
    use system_trade;
    show tables;
EOD
)
do
  echo [log] adx generation for $table.
  run_query_table $table
done

