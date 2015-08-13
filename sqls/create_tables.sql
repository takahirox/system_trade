use system_trade;

drop table if exists nk225_future_mini_daily;
create table nk225_future_mini_daily (
  date date,
  type int,
  start int,
  high int,
  low int,
  end int,
  voulme int,
  trading_value int,
  ma5 int,
  ma10 int,
  ma25 int,
  ma75 int
);
describe nk225_future_mini_daily;

drop table if exists nk225_future_mini_minutely;
create table nk225_future_mini_minutely (
  date date,
  time time,
  start int,
  high int,
  low int,
  end int,
  voulme int,
  trading_value int,
  ma5 int,
  ma10 int,
  ma25 int,
  ma75 int
);
describe nk225_future_mini_minutely;

show tables;

