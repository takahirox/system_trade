# system_trade

This system supports easy algorithmic trading.


## Features

- automatically gather price values
- automatically report daily signals to you via mail
- easy to write/check strategy
- NOT automatically buy/sell. You need to do that manually


## Note

- This system is expected to run on Lubuntu
- Configure visudo not to require password for "sudo rtcwake"
- Configure crontab to daily run tool/run_daily.sh 
- Configure Power/Display management system not to sleep while run_daily.sh running
- Configure postfix if you need to avoid op25b


## dependencies

- MySQL
- some Linux system tools (mail, rtcwake, etc.)
- gnuplot
