-- sample strategy
-- 2015/08/25

-- table=nk225_future_mini_daily
-- entry_from_trigger=1
-- leave_from_entry=1
-- entry_time=open
-- leave_time=open
-- is_buy=true

from nk225_future_mini_daily t
where t.id>=0
