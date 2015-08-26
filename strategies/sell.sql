-- sample strategy
-- 2015/08/25

select t1.close trigger_value,
       t2.open entry_value,
       t3.open leave_value,
       false is_buy
from nk225_future_mini_daily t1,
     nk225_future_mini_daily t2,
     nk225_future_mini_daily t3
where t1.id+1=t2.id
  and t2.id+1=t3.id
;
