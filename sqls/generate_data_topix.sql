-- generate topix daily data
insert into topix_daily(date, open, high, low, close)
select t1.date,
       t1.open,
       if(t2.open != 0.0,
          GREATEST(t1.high, t2.high),
          t1.high),
       if(t2.open != 0.0,
          LEAST(t1.low, t2.low),
          t1.low),
       if(t2.open != 0.0,
          t2.close,
          t1.close)
from topix_daily_master t1,
     topix_daily_master t2
where t1.date = t2.date
  and t1.type = 0
  and t2.type = 1
order by t1.date;


-- generate topix daily id
update topix_daily t1
  inner join (
    select t.date date,
           @n:=@n+1 id
    from topix_daily t,
         (select @n:=0) dmy
    order by t.date
  ) t2
  on t1.date=t2.date
  set t1.id=t2.id;


-- generate topix daily change
update topix_daily t3
  inner join (
    select t1.date date,
           t1.close-t2.close change_price,
           (t1.close-t2.close)/t2.close*100 change_percentage
    from topix_daily t1,
         topix_daily t2
    where t1.id=t2.id+1
  ) t4
  on t3.date=t4.date
  set t3.change_price=t4.change_price,
      t3.change_percentage=t4.change_percentage;


-- generate topix daily stick
update topix_daily t1
  inner join (
    select date date,
           close-open candle
    from topix_daily
    order by date
  ) t2
  on t1.date=t2.date
  set t1.candle=t2.candle;


-- generate topix daily ma
update topix_daily t3
  inner join (
    select t1.date date,
           avg(t2.close) ma
    from topix_daily t1,
         topix_daily t2
    where t2.id between t1.id-4 and t1.id
    group by t1.date
  ) t4
  on t3.date=t4.date
  set t3.ma5=t4.ma;

update topix_daily t3
  inner join (
    select t1.date date,
           avg(t2.close) ma
    from topix_daily t1,
         topix_daily t2
    where t2.id between t1.id-9 and t1.id
    group by t1.date
  ) t4
  on t3.date=t4.date
  set t3.ma10=t4.ma;

update topix_daily t3
  inner join (
    select t1.date date,
           avg(t2.close) ma
    from topix_daily t1,
         topix_daily t2
    where t2.id between t1.id-24 and t1.id
    group by t1.date
  ) t4
  on t3.date=t4.date
  set t3.ma25=t4.ma;

update topix_daily t3
  inner join (
    select t1.date date,
           avg(t2.close) ma
    from topix_daily t1,
         topix_daily t2
    where t2.id between t1.id-74 and t1.id
    group by t1.date
  ) t4
  on t3.date=t4.date
  set t3.ma75=t4.ma;

