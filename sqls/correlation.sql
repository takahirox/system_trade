/**
 * this is a template file
 */

select
-- y  YEAR(t.date) year,
-- m  MONTH(t.date) month,
  sum((t.x - a.x) * (t.y - a.y)) /
  (
    sqrt(sum(power((t.x - a.x) ,2))) *
    sqrt(sum(power((t.y - a.y) ,2)))
  ) correlation
from (
  select
    t1.date date,
    t1.close x,
    t2.close y
  from
    %%table1%% t1,
    %%table2%% t2
  where
    t1.date=t2.date
) t,
(
  select
    t1.date date,
    avg(t1.close) x,
    avg(t2.close) y
  from
    %%table1%% t1,
    %%table2%% t2
  where
    t1.date=t2.date
-- y  group by
-- y    YEAR(t1.date)
-- m    , MONTH(t1.date)
) a
-- y where
-- y   YEAR(t.date)=YEAR(a.date)
-- m   and MONTH(t.date)=MONTH(a.date)
-- y group by
-- y   YEAR(t.date)
-- m   , MONTH(t.date)
-- y order by
-- y   YEAR(t.date)
-- m   , MONTH(t.date)
;
