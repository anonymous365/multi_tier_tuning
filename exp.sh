#!/bin/sh
logfile=$1
echo "Start at rate=20 END at rate=55" > $logfile
date >> $logfile
./src/httperf --server=192.168.0.22 --uri=/memcache.php --num-conns=4800 --rate=20 --num-calls=100
date >> $logfile
./src/httperf --server=192.168.0.22 --uri=/memcache.php --num-conns=5040 --rate=21 --num-calls=100
date >> $logfile
./src/httperf --server=192.168.0.22 --uri=/memcache.php --num-conns=5280 --rate=22 --num-calls=100
date >> $logfile
./src/httperf --server=192.168.0.22 --uri=/memcache.php --num-conns=5520 --rate=23 --num-calls=100
date >> $logfile
./src/httperf --server=192.168.0.22 --uri=/memcache.php --num-conns=5760 --rate=24 --num-calls=100
date >> $logfile
./src/httperf --server=192.168.0.22 --uri=/memcache.php --num-conns=6000 --rate=25 --num-calls=100
date >> $logfile
./src/httperf --server=192.168.0.22 --uri=/memcache.php --num-conns=6240 --rate=26 --num-calls=100
date >> $logfile
./src/httperf --server=192.168.0.22 --uri=/memcache.php --num-conns=6480 --rate=27 --num-calls=100
date >> $logfile
./src/httperf --server=192.168.0.22 --uri=/memcache.php --num-conns=6720 --rate=28 --num-calls=100
date >> $logfile
./src/httperf --server=192.168.0.22 --uri=/memcache.php --num-conns=6960 --rate=29 --num-calls=100
date >> $logfile
./src/httperf --server=192.168.0.22 --uri=/memcache.php --num-conns=7200 --rate=30 --num-calls=100
date >> $logfile
./src/httperf --server=192.168.0.22 --uri=/memcache.php --num-conns=7440 --rate=31 --num-calls=100
date >> $logfile
./src/httperf --server=192.168.0.22 --uri=/memcache.php --num-conns=7680 --rate=32 --num-calls=100
date >> $logfile
./src/httperf --server=192.168.0.22 --uri=/memcache.php --num-conns=7920 --rate=33 --num-calls=100
date >> $logfile
./src/httperf --server=192.168.0.22 --uri=/memcache.php --num-conns=8160 --rate=34 --num-calls=100
date >> $logfile
./src/httperf --server=192.168.0.22 --uri=/memcache.php --num-conns=8400 --rate=35 --num-calls=100
date >> $logfile
./src/httperf --server=192.168.0.22 --uri=/memcache.php --num-conns=8640 --rate=36 --num-calls=100
date >> $logfile
./src/httperf --server=192.168.0.22 --uri=/memcache.php --num-conns=8880 --rate=37 --num-calls=100
date >> $logfile
./src/httperf --server=192.168.0.22 --uri=/memcache.php --num-conns=9120 --rate=38 --num-calls=100
date >> $logfile
./src/httperf --server=192.168.0.22 --uri=/memcache.php --num-conns=9360 --rate=39 --num-calls=100
date >> $logfile
./src/httperf --server=192.168.0.22 --uri=/memcache.php --num-conns=9600 --rate=40 --num-calls=100
date >> $logfile
./src/httperf --server=192.168.0.22 --uri=/memcache.php --num-conns=9840 --rate=41 --num-calls=100
date >> $logfile
./src/httperf --server=192.168.0.22 --uri=/memcache.php --num-conns=10080 --rate=42 --num-calls=100
date >> $logfile
./src/httperf --server=192.168.0.22 --uri=/memcache.php --num-conns=10320 --rate=43 --num-calls=100
date >> $logfile
./src/httperf --server=192.168.0.22 --uri=/memcache.php --num-conns=10560 --rate=44 --num-calls=100
date >> $logfile
./src/httperf --server=192.168.0.22 --uri=/memcache.php --num-conns=10800 --rate=45 --num-calls=100
date >> $logfile
./src/httperf --server=192.168.0.22 --uri=/memcache.php --num-conns=11040 --rate=46 --num-calls=100
date >> $logfile
./src/httperf --server=192.168.0.22 --uri=/memcache.php --num-conns=11280 --rate=47 --num-calls=100
date >> $logfile
./src/httperf --server=192.168.0.22 --uri=/memcache.php --num-conns=11520 --rate=48 --num-calls=100
date >> $logfile
./src/httperf --server=192.168.0.22 --uri=/memcache.php --num-conns=11760 --rate=49 --num-calls=100
date >> $logfile
./src/httperf --server=192.168.0.22 --uri=/memcache.php --num-conns=12000 --rate=50 --num-calls=100
date >> $logfile
./src/httperf --server=192.168.0.22 --uri=/memcache.php --num-conns=12240 --rate=51 --num-calls=100
date >> $logfile
./src/httperf --server=192.168.0.22 --uri=/memcache.php --num-conns=12480 --rate=52 --num-calls=100
date >> $logfile
./src/httperf --server=192.168.0.22 --uri=/memcache.php --num-conns=12720 --rate=53 --num-calls=100
date >> $logfile
./src/httperf --server=192.168.0.22 --uri=/memcache.php --num-conns=12960 --rate=54 --num-calls=100
date >> $logfile
./src/httperf --server=192.168.0.22 --uri=/memcache.php --num-conns=13200 --rate=55 --num-calls=100
date >> $logfile
