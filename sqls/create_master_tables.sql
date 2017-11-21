use system_trade;


drop table if exists nk225_daily_master;
create table nk225_daily_master (
  date date,
  type int,
  open float(7,2),
  high float(7,2),
  low float(7,2),
  close float(7,2)
);
describe nk225_daily_master;


drop table if exists topix_daily_master;
create table topix_daily_master (
  date date,
  type int,
  open float(7,2),
  high float(7,2),
  low float(7,2),
  close float(7,2)
);
describe topix_daily_master;


drop table if exists nk225_future_mini_daily_master;
create table nk225_future_mini_daily_master (
  date date,
  type int,
  open int,
  high int,
  low int,
  close int,
  volume int,
  trading_value bigint,
  daily_id int
);
describe nk225_future_mini_daily_master;


drop table if exists nk225_future_mini_minutely_master;
create table nk225_future_mini_minutely_master (
  date date,
  time time,
  open int,
  high int,
  low int,
  close int,
  volume int,
  trading_value bigint,
  ma5 float(7,2),
  ma5_change float(7,2),
  ma10 float(7,2),
  ma10_change float(7,2),
  ma25 float(7,2),
  ma25_change float(7,2),
  ma75 float(7,2),
  ma75_change float(7,2)
);
describe nk225_future_mini_minutely_master;


drop table if exists dji_daily_master;
create table dji_daily_master (
  date date,
  open float(7,2),
  high float(7,2),
  low float(7,2),
  close float(7,2),
  volume int
);
describe dji_daily_master;


drop table if exists dji_future_mini_daily_master;
create table dji_future_mini_daily_master (
  date date,
  open float(7,2),
  high float(7,2),
  low float(7,2),
  close float(7,2)
);
describe dji_future_mini_daily_master;


drop table if exists usdjpy_daily_master;
create table usdjpy_daily_master (
  date date,
  open float(5,2),
  high float(5,2),
  low float(5,2),
  close float(5,2)
);
describe usdjpy_daily_master;


