-- generate topix weekly basic data from topix daily
insert into topix_weekly(date, open, high, low, close)
select min(t.date) date,
       (select t2.open
        from topix_daily t2
        where t2.date=min(t.date)) open,
       max(t.high) high,
       min(t.low) low,
       (select t2.close
        from topix_daily t2
        where t2.date=max(t.date)) close
from topix_daily t
group by YEARWEEK(t.date)
order by t.date;


-- generate topix weekly id
update topix_weekly t1
  inner join (
    select t.date date,
           @n:=@n+1 id
    from topix_weekly t,
         (select @n:=0) dmy
    order by t.date
  ) t2
  on t1.date=t2.date
  set t1.id=t2.id;


-- generate topix weekly change
update topix_weekly t3
  inner join (
    select t1.date date,
           t1.close-t2.close change_price,
           (t1.close-t2.close)/t2.close*100 change_percentage
    from topix_weekly t1,
         topix_weekly t2
    where t1.id=t2.id+1
  ) t4
  on t3.date=t4.date
  set t3.change_price=t4.change_price,
      t3.change_percentage=t4.change_percentage;


-- generate topix_weekly candle and beard
update topix_weekly t1
  inner join (
    select date date,
           close-open candle,
           high-GREATEST(open, close) top_beard,
           LEAST(open, close)-low bottom_beard
    from topix_weekly
    order by date
  ) t2
  on t1.date=t2.date
  set t1.candle=t2.candle,
      t1.top_beard=t2.top_beard,
      t1.bottom_beard=t2.bottom_beard;


-- generate topix_weekly beard
update topix_weekly t1
  inner join (
    select date date,
           close-open candle
    from topix_weekly
    order by date
  ) t2
  on t1.date=t2.date
  set t1.candle=t2.candle;


-- generate topix weekly ma
update topix_weekly t3
  inner join (
    select t1.date date,
           avg(t2.close) ma
    from topix_weekly t1,
         topix_weekly t2
    where t2.id between t1.id-4 and t1.id
    group by t1.date
  ) t4
  on t3.date=t4.date
  set t3.ma5=t4.ma;

update topix_weekly t3
  inner join (
    select t1.date date,
           avg(t2.close) ma
    from topix_weekly t1,
         topix_weekly t2
    where t2.id between t1.id-9 and t1.id
    group by t1.date
  ) t4
  on t3.date=t4.date
  set t3.ma10=t4.ma;

update topix_weekly t3
  inner join (
    select t1.date date,
           avg(t2.close) ma
    from topix_weekly t1,
         topix_weekly t2
    where t2.id between t1.id-24 and t1.id
    group by t1.date
  ) t4
  on t3.date=t4.date
  set t3.ma25=t4.ma;

update topix_weekly t3
  inner join (
    select t1.date date,
           avg(t2.close) ma
    from topix_weekly t1,
         topix_weekly t2
    where t2.id between t1.id-74 and t1.id
    group by t1.date
  ) t4
  on t3.date=t4.date
  set t3.ma75=t4.ma;

update topix_weekly t3
  inner join (
    select t1.date date,
           t1.ma5-t2.ma5 ma5_change,
           t1.ma10-t2.ma10 ma10_change,
           t1.ma25-t2.ma25 ma25_change,
           t1.ma75-t2.ma75 ma75_change
    from topix_weekly t1,
         topix_weekly t2
    where t1.id=t2.id+1
  ) t4
  on t3.date=t4.date
  set t3.ma5_change=t4.ma5_change,
      t3.ma10_change=t4.ma10_change,
      t3.ma25_change=t4.ma25_change,
      t3.ma75_change=t4.ma75_change;

