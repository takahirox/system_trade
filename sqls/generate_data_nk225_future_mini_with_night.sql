-- generate nk225_future_mini daily data
alter table nk225_future_mini_daily_master add daily_id int;

update nk225_future_mini_daily_master t1
  inner join (
    select t.date date,
           @n:=@n+1 id
    from (
      select distinct date
      from nk225_future_mini_daily_master
      order by date
    ) t,
         (select @n:=0) dmy
    order by t.date
  ) t2
  on t1.date=t2.date
  set t1.daily_id=t2.id;

insert into nk225_future_mini_daily_with_night(date, open, high, low, close,
                                               volume, trading_value)
select t1.date,
       if(t3.open != 0.0,
          t3.open,
          t1.open),
       if(t2.open != 0.0 and t3.open != 0.0,
          GREATEST(t1.high, t2.high, t3.high),
          if(t2.open = 0.0 and t3.open != 0.0,
            GREATEST(t1.high, t3.high),
            if(t2.open != 0.0 and t3.open = 0.0,
               GREATEST(t1.high, t2.high),
               t1.high
            )
          )
       ),
       if(t2.open != 0.0 and t3.open != 0.0,
          LEAST(t1.low, t2.low, t3.low),
          if(t2.open = 0.0 and t3.open != 0.0,
            LEAST(t1.low, t3.low),
            if(t2.open != 0.0 and t3.open = 0.0,
               LEAST(t1.low, t2.low),
               t1.low
            )
          )
       ),
       if(t2.open != 0.0,
          t2.close,
          t1.close),
       if(t2.open != 0.0 and t3.open != 0.0,
          t1.volume+t2.volume+t3.volume,
          if(t2.open = 0.0 and t3.open != 0.0,
            t1.volume+t3.volume,
            if(t2.open != 0.0 and t3.open = 0.0,
               t1.volume+t2.volume,
               t1.volume
            )
          )
       ),
       if(t2.open != 0.0 and t3.open != 0.0,
          t1.trading_value+t2.trading_value+t3.trading_value,
          if(t2.open = 0.0 and t3.open != 0.0,
            t1.trading_value+t3.trading_value,
            if(t2.open != 0.0 and t3.open = 0.0,
               t1.trading_value+t2.trading_value,
               t1.trading_value
            )
          )
       )
from nk225_future_mini_daily_master t1,
     nk225_future_mini_daily_master t2,
     nk225_future_mini_daily_master t3
where t1.date = t2.date
  and t1.daily_id = t3.daily_id+1
  and t1.type = 0
  and t2.type = 1
  and t3.type = 2
order by t1.date;

alter table nk225_future_mini_daily_master drop column daily_id;


-- generate nk225_future_mini daily id
update nk225_future_mini_daily_with_night t1
  inner join (
    select t.date date,
           @n:=@n+1 id
    from nk225_future_mini_daily_with_night t,
         (select @n:=0) dmy
    order by t.date
  ) t2
  on t1.date=t2.date
  set t1.id=t2.id;


-- generate nk225_future_mini daily change
update nk225_future_mini_daily_with_night t3
  inner join (
    select t1.date date,
           t1.close-t2.close change_price,
           (t1.close-t2.close)/t2.close*100 change_percentage
    from nk225_future_mini_daily_with_night t1,
         nk225_future_mini_daily_with_night t2
    where t1.id=t2.id+1
  ) t4
  on t3.date=t4.date
  set t3.change_price=t4.change_price,
      t3.change_percentage=t4.change_percentage;


-- generate nk225_future_mini_daily_with_night candle
update nk225_future_mini_daily_with_night t1
  inner join (
    select date date,
           close-open candle,
           high-GREATEST(open, close) top_beard,
           LEAST(open, close)-low bottom_beard
    from nk225_future_mini_daily_with_night
    order by date
  ) t2
  on t1.date=t2.date
  set t1.candle=t2.candle,
      t1.top_beard=t2.top_beard,
      t1.bottom_beard=t2.bottom_beard;


-- generate nk225_future_mini daily ma
update nk225_future_mini_daily_with_night t3
  inner join (
    select t1.date date,
           avg(t2.close) ma
    from nk225_future_mini_daily_with_night t1,
         nk225_future_mini_daily_with_night t2
    where t2.id between t1.id-4 and t1.id
    group by t1.date
  ) t4
  on t3.date=t4.date
  set t3.ma5=t4.ma;

update nk225_future_mini_daily_with_night t3
  inner join (
    select t1.date date,
           avg(t2.close) ma
    from nk225_future_mini_daily_with_night t1,
         nk225_future_mini_daily_with_night t2
    where t2.id between t1.id-9 and t1.id
    group by t1.date
  ) t4
  on t3.date=t4.date
  set t3.ma10=t4.ma;

update nk225_future_mini_daily_with_night t3
  inner join (
    select t1.date date,
           avg(t2.close) ma
    from nk225_future_mini_daily_with_night t1,
         nk225_future_mini_daily_with_night t2
    where t2.id between t1.id-24 and t1.id
    group by t1.date
  ) t4
  on t3.date=t4.date
  set t3.ma25=t4.ma;

update nk225_future_mini_daily_with_night t3
  inner join (
    select t1.date date,
           avg(t2.close) ma
    from nk225_future_mini_daily_with_night t1,
         nk225_future_mini_daily_with_night t2
    where t2.id between t1.id-74 and t1.id
    group by t1.date
  ) t4
  on t3.date=t4.date
  set t3.ma75=t4.ma;

update nk225_future_mini_daily_with_night t3
  inner join (
    select t1.date date,
           t1.ma5-t2.ma5 ma5_change,
           t1.ma10-t2.ma10 ma10_change,
           t1.ma25-t2.ma25 ma25_change,
           t1.ma75-t2.ma75 ma75_change
    from nk225_future_mini_daily_with_night t1,
         nk225_future_mini_daily_with_night t2
    where t1.id=t2.id+1
  ) t4
  on t3.date=t4.date
  set t3.ma5_change=t4.ma5_change,
      t3.ma10_change=t4.ma10_change,
      t3.ma25_change=t4.ma25_change,
      t3.ma75_change=t4.ma75_change;

