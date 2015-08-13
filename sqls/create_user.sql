delete from mysql.user where User='takahiro';
insert into mysql.user (User, Host, Password)
  values('takahiro', 'localhost', '');
flush privileges;
select User, Host, Password from mysql.user;
grant all privileges on system_trade.* to takahiro@localhost;
flush privileges;
show grants for 'takahiro'@'localhost';

