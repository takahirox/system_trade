select 
       t3.open-t2.open value
from nk225_future_mini_daily t1,
     nk225_future_mini_daily t2,
     nk225_future_mini_daily t3
where t1.close>t1.ma5
  and t1.id+1=t2.id
  and t2.id+1=t3.id

