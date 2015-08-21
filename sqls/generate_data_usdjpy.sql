-- generate usdjpy daily data
insert into usdjpy_daily(date, open, high, low, close)
select t1.date,
       t1.open,
       t1.high,
       t1.low,
       t1.close
from usdjpy_daily_master t1
order by t1.date;


-- generate usdjpy daily id
update usdjpy_daily t1
  inner join (
    select t.date date,
           @n:=@n+1 id
    from usdjpy_daily t,
         (select @n:=0) dmy
    order by t.date
  ) t2
  on t1.date=t2.date
  set t1.id=t2.id;


-- generate usdjpy daily change
update usdjpy_daily t3
  inner join (
    select t1.date date,
           t1.close-t2.close change_price,
           (t1.close-t2.close)/t2.close*100 change_percentage
    from usdjpy_daily t1,
         usdjpy_daily t2
    where t1.id=t2.id+1
  ) t4
  on t3.date=t4.date
  set t3.change_price=t4.change_price,
      t3.change_percentage=t4.change_percentage;


-- generate usdjpy_daily stick
update usdjpy_daily t1
  inner join (
    select date date,
           close-open candle
    from usdjpy_daily
    order by date
  ) t2
  on t1.date=t2.date
  set t1.candle=t2.candle;


-- generate usdjpy daily ma
update usdjpy_daily t3
  inner join (
    select t1.date date,
           avg(t2.close) ma
    from usdjpy_daily t1,
         usdjpy_daily t2
    where t2.id between t1.id-4 and t1.id
    group by t1.date
  ) t4
  on t3.date=t4.date
  set t3.ma5=t4.ma;

update usdjpy_daily t3
  inner join (
    select t1.date date,
           avg(t2.close) ma
    from usdjpy_daily t1,
         usdjpy_daily t2
    where t2.id between t1.id-9 and t1.id
    group by t1.date
  ) t4
  on t3.date=t4.date
  set t3.ma10=t4.ma;

update usdjpy_daily t3
  inner join (
    select t1.date date,
           avg(t2.close) ma
    from usdjpy_daily t1,
         usdjpy_daily t2
    where t2.id between t1.id-24 and t1.id
    group by t1.date
  ) t4
  on t3.date=t4.date
  set t3.ma25=t4.ma;

update usdjpy_daily t3
  inner join (
    select t1.date date,
           avg(t2.close) ma
    from usdjpy_daily t1,
         usdjpy_daily t2
    where t2.id between t1.id-74 and t1.id
    group by t1.date
  ) t4
  on t3.date=t4.date
  set t3.ma75=t4.ma;

update usdjpy_daily t3
  inner join (
    select t1.date date,
           t1.ma5-t2.ma5 ma5_change,
           t1.ma10-t2.ma10 ma10_change,
           t1.ma25-t2.ma25 ma25_change,
           t1.ma75-t2.ma75 ma75_change
    from usdjpy_daily t1,
         usdjpy_daily t2
    where t1.id=t2.id+1
  ) t4
  on t3.date=t4.date
  set t3.ma5_change=t4.ma5_change,
      t3.ma10_change=t4.ma10_change,
      t3.ma25_change=t4.ma25_change,
      t3.ma75_change=t4.ma75_change;
