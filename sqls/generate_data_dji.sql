-- generate dji daily data
insert into dji_daily(date, open, high, low, close)
select t1.date,
       t1.open,
       t1.high,
       t1.low,
       t1.close
from dji_daily_master t1
order by t1.date;


-- generate dji daily id
update dji_daily t1
  inner join (
    select t.date date,
           @n:=@n+1 id
    from dji_daily t,
         (select @n:=0) dmy
    order by t.date
  ) t2
  on t1.date=t2.date
  set t1.id=t2.id;


-- generate dji daily change
update dji_daily t3
  inner join (
    select t1.date date,
           t1.close-t2.close change_price,
           (t1.close-t2.close)/t2.close*100 change_percentage
    from dji_daily t1,
         dji_daily t2
    where t1.id=t2.id+1
  ) t4
  on t3.date=t4.date
  set t3.change_price=t4.change_price,
      t3.change_percentage=t4.change_percentage;


-- generate dji daily ma
update dji_daily t3
  inner join (
    select t1.date date,
           avg(t2.close) ma
    from dji_daily t1,
         dji_daily t2
    where t2.id between t1.id-4 and t1.id
    group by t1.date
  ) t4
  on t3.date=t4.date
  set t3.ma5=t4.ma;

update dji_daily t3
  inner join (
    select t1.date date,
           avg(t2.close) ma
    from dji_daily t1,
         dji_daily t2
    where t2.id between t1.id-9 and t1.id
    group by t1.date
  ) t4
  on t3.date=t4.date
  set t3.ma10=t4.ma;

update dji_daily t3
  inner join (
    select t1.date date,
           avg(t2.close) ma
    from dji_daily t1,
         dji_daily t2
    where t2.id between t1.id-24 and t1.id
    group by t1.date
  ) t4
  on t3.date=t4.date
  set t3.ma25=t4.ma;

update dji_daily t3
  inner join (
    select t1.date date,
           avg(t2.close) ma
    from dji_daily t1,
         dji_daily t2
    where t2.id between t1.id-74 and t1.id
    group by t1.date
  ) t4
  on t3.date=t4.date
  set t3.ma75=t4.ma;

