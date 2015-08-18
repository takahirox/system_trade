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


drop table if exists nk225_daily;
create table nk225_daily (
  date date,
  open float(7,2),
  high float(7,2),
  low float(7,2),
  close float(7,2),
  id int,
  change_price float(7,2),
  change_percentage float(5,2),
  candle float(7,2),
  ma5 float(7,2),
  ma5_change float(7,2),
  ma10 float(7,2),
  ma10_change float(7,2),
  ma25 float(7,2),
  ma25_change float(7,2),
  ma75 float(7,2),
  ma75_change float(7,2)
);
describe nk225_daily;


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


drop table if exists topix_daily;
create table topix_daily (
  date date,
  open float(7,2),
  high float(7,2),
  low float(7,2),
  close float(7,2),
  id int,
  change_price float(7,2),
  change_percentage float(5,2),
  candle float(7,2),
  ma5 float(7,2),
  ma5_change float(7,2),
  ma10 float(7,2),
  ma10_change float(7,2),
  ma25 float(7,2),
  ma25_change float(7,2),
  ma75 float(7,2),
  ma75_change float(7,2)
);
describe topix_daily;


drop table if exists nk225_future_mini_daily_master;
create table nk225_future_mini_daily_master (
  date date,
  type int,
  open int,
  high int,
  low int,
  close int,
  volume int,
  trading_value int
);
describe nk225_future_mini_daily_master;


drop table if exists nk225_future_mini_daily;
create table nk225_future_mini_daily (
  date date,
  open int,
  high int,
  low int,
  close int,
  volume int,
  trading_value int,
  id int,
  change_price float(7,2),
  change_percentage float(5,2),
  candle int,
  ma5 float(7,2),
  ma5_change float(7,2),
  ma10 float(7,2),
  ma10_change float(7,2),
  ma25 float(7,2),
  ma25_change float(7,2),
  ma75 float(7,2),
  ma75_change float(7,2)
);
describe nk225_future_mini_daily;


drop table if exists nk225_future_mini_daily_with_night;
create table nk225_future_mini_daily_with_night (
  date date,
  open int,
  high int,
  low int,
  close int,
  volume int,
  trading_value int,
  id int,
  change_price float(7,2),
  change_percentage float(5,2),
  candle int,
  ma5 float(7,2),
  ma5_change float(7,2),
  ma10 float(7,2),
  ma10_change float(7,2),
  ma25 float(7,2),
  ma25_change float(7,2),
  ma75 float(7,2),
  ma75_change float(7,2)
);
describe nk225_future_mini_daily_with_night;


drop table if exists nk225_future_mini_minutely;
create table nk225_future_mini_minutely (
  date date,
  time time,
  open int,
  high int,
  low int,
  close int,
  volume int,
  trading_value int,
  ma5 float(7,2),
  ma5_change float(7,2),
  ma10 float(7,2),
  ma10_change float(7,2),
  ma25 float(7,2),
  ma25_change float(7,2),
  ma75 float(7,2),
  ma75_change float(7,2)
);
describe nk225_future_mini_minutely;


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


drop table if exists dji_daily;
create table dji_daily (
  date date,
  open float(7,2),
  high float(7,2),
  low float(7,2),
  close float(7,2),
  id int,
  change_price float(7,2),
  change_percentage float(5,2),
  candle float(7,2),
  ma5 float(7,2),
  ma5_change float(7,2),
  ma10 float(7,2),
  ma10_change float(7,2),
  ma25 float(7,2),
  ma25_change float(7,2),
  ma75 float(7,2),
  ma75_change float(7,2)
);
describe dji_daily;


show tables;

