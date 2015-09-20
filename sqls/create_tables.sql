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
  top_beard float(7,2),
  bottom_beard float(7,2),
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


drop table if exists nk225_weekly;
create table nk225_weekly (
  date date,
  open float(7,2),
  high float(7,2),
  low float(7,2),
  close float(7,2),
  id int,
  change_price float(7,2),
  change_percentage float(5,2),
  candle float(7,2),
  top_beard float(7,2),
  bottom_beard float(7,2),
  ma5 float(7,2),
  ma5_change float(7,2),
  ma10 float(7,2),
  ma10_change float(7,2),
  ma25 float(7,2),
  ma25_change float(7,2),
  ma75 float(7,2),
  ma75_change float(7,2)
);
describe nk225_weekly;


drop table if exists nk225_monthly;
create table nk225_monthly (
  date date,
  open float(7,2),
  high float(7,2),
  low float(7,2),
  close float(7,2),
  id int,
  change_price float(7,2),
  change_percentage float(5,2),
  candle float(7,2),
  top_beard float(7,2),
  bottom_beard float(7,2),
  ma5 float(7,2),
  ma5_change float(7,2),
  ma10 float(7,2),
  ma10_change float(7,2),
  ma25 float(7,2),
  ma25_change float(7,2),
  ma75 float(7,2),
  ma75_change float(7,2)
);
describe nk225_monthly;


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
  top_beard float(7,2),
  bottom_beard float(7,2),
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


drop table if exists topix_weekly;
create table topix_weekly (
  date date,
  open float(7,2),
  high float(7,2),
  low float(7,2),
  close float(7,2),
  id int,
  change_price float(7,2),
  change_percentage float(5,2),
  candle float(7,2),
  top_beard float(7,2),
  bottom_beard float(7,2),
  ma5 float(7,2),
  ma5_change float(7,2),
  ma10 float(7,2),
  ma10_change float(7,2),
  ma25 float(7,2),
  ma25_change float(7,2),
  ma75 float(7,2),
  ma75_change float(7,2)
);
describe topix_weekly;


drop table if exists topix_monthly;
create table topix_monthly (
  date date,
  open float(7,2),
  high float(7,2),
  low float(7,2),
  close float(7,2),
  id int,
  change_price float(7,2),
  change_percentage float(5,2),
  candle float(7,2),
  top_beard float(7,2),
  bottom_beard float(7,2),
  ma5 float(7,2),
  ma5_change float(7,2),
  ma10 float(7,2),
  ma10_change float(7,2),
  ma25 float(7,2),
  ma25_change float(7,2),
  ma75 float(7,2),
  ma75_change float(7,2)
);
describe topix_monthly;


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
  top_beard int,
  bottom_beard int,
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


drop table if exists nk225_future_mini_weekly;
create table nk225_future_mini_weekly (
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
  top_beard int,
  bottom_beard int,
  ma5 float(7,2),
  ma5_change float(7,2),
  ma10 float(7,2),
  ma10_change float(7,2),
  ma25 float(7,2),
  ma25_change float(7,2),
  ma75 float(7,2),
  ma75_change float(7,2)
);
describe nk225_future_mini_weekly;


drop table if exists nk225_future_mini_monthly;
create table nk225_future_mini_monthly (
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
  top_beard int,
  bottom_beard int,
  ma5 float(7,2),
  ma5_change float(7,2),
  ma10 float(7,2),
  ma10_change float(7,2),
  ma25 float(7,2),
  ma25_change float(7,2),
  ma75 float(7,2),
  ma75_change float(7,2)
);
describe nk225_future_mini_monthly;


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
  top_beard int,
  bottom_beard int,
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


drop table if exists nk225_future_mini_weekly_with_night;
create table nk225_future_mini_weekly_with_night (
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
  top_beard int,
  bottom_beard int,
  ma5 float(7,2),
  ma5_change float(7,2),
  ma10 float(7,2),
  ma10_change float(7,2),
  ma25 float(7,2),
  ma25_change float(7,2),
  ma75 float(7,2),
  ma75_change float(7,2)
);
describe nk225_future_mini_weekly_with_night;


drop table if exists nk225_future_mini_monthly_with_night;
create table nk225_future_mini_monthly_with_night (
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
  top_beard int,
  bottom_beard int,
  ma5 float(7,2),
  ma5_change float(7,2),
  ma10 float(7,2),
  ma10_change float(7,2),
  ma25 float(7,2),
  ma25_change float(7,2),
  ma75 float(7,2),
  ma75_change float(7,2)
);
describe nk225_future_mini_monthly_with_night;


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
  top_beard float(7,2),
  bottom_beard float(7,2),
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


drop table if exists dji_weekly;
create table dji_weekly (
  date date,
  open float(7,2),
  high float(7,2),
  low float(7,2),
  close float(7,2),
  id int,
  change_price float(7,2),
  change_percentage float(5,2),
  candle float(7,2),
  top_beard float(7,2),
  bottom_beard float(7,2),
  ma5 float(7,2),
  ma5_change float(7,2),
  ma10 float(7,2),
  ma10_change float(7,2),
  ma25 float(7,2),
  ma25_change float(7,2),
  ma75 float(7,2),
  ma75_change float(7,2)
);
describe dji_weekly;


drop table if exists dji_monthly;
create table dji_monthly (
  date date,
  open float(7,2),
  high float(7,2),
  low float(7,2),
  close float(7,2),
  id int,
  change_price float(7,2),
  change_percentage float(5,2),
  candle float(7,2),
  top_beard float(7,2),
  bottom_beard float(7,2),
  ma5 float(7,2),
  ma5_change float(7,2),
  ma10 float(7,2),
  ma10_change float(7,2),
  ma25 float(7,2),
  ma25_change float(7,2),
  ma75 float(7,2),
  ma75_change float(7,2)
);
describe dji_monthly;


drop table if exists usdjpy_daily_master;
create table usdjpy_daily_master (
  date date,
  open float(5,2),
  high float(5,2),
  low float(5,2),
  close float(5,2)
);
describe usdjpy_daily_master;


drop table if exists usdjpy_daily;
create table usdjpy_daily (
  date date,
  open float(5,2),
  high float(5,2),
  low float(5,2),
  close float(5,2),
  id int,
  change_price float(5,2),
  change_percentage float(5,2),
  candle float(5,2),
  top_beard float(5,2),
  bottom_beard float(5,2),
  ma5 float(5,2),
  ma5_change float(5,2),
  ma10 float(5,2),
  ma10_change float(5,2),
  ma25 float(5,2),
  ma25_change float(5,2),
  ma75 float(5,2),
  ma75_change float(5,2)
);
describe usdjpy_daily;


drop table if exists usdjpy_weekly;
create table usdjpy_weekly (
  date date,
  open float(5,2),
  high float(5,2),
  low float(5,2),
  close float(5,2),
  id int,
  change_price float(5,2),
  change_percentage float(5,2),
  candle float(5,2),
  top_beard float(5,2),
  bottom_beard float(5,2),
  ma5 float(5,2),
  ma5_change float(5,2),
  ma10 float(5,2),
  ma10_change float(5,2),
  ma25 float(5,2),
  ma25_change float(5,2),
  ma75 float(5,2),
  ma75_change float(5,2)
);
describe usdjpy_weekly;


drop table if exists usdjpy_monthly;
create table usdjpy_monthly (
  date date,
  open float(5,2),
  high float(5,2),
  low float(5,2),
  close float(5,2),
  id int,
  change_price float(5,2),
  change_percentage float(5,2),
  candle float(5,2),
  top_beard float(5,2),
  bottom_beard float(5,2),
  ma5 float(5,2),
  ma5_change float(5,2),
  ma10 float(5,2),
  ma10_change float(5,2),
  ma25 float(5,2),
  ma25_change float(5,2),
  ma75 float(5,2),
  ma75_change float(5,2)
);
describe usdjpy_monthly;


show tables;

