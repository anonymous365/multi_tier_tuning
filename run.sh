#!/bin/sh
mems=$1
#wc=$2
#pmc=$3
webs=3
echo "Run 1" > run.log
date >> run.log
./exp.sh etime_${webs}web_run1.log | tee exp_${mems}mem_${webs}web_run1.log
ssh -i ~/compass.pem ubuntu@192.168.0.22 "~/refresh_web.sh 1 ${webs} ${mems}"
sleep 5

echo "Run 2" >> run.log
date >> run.log
./exp.sh etime_${webs}web_run2.log | tee exp_${mems}mem_${webs}web_run2.log
ssh -i ~/compass.pem ubuntu@192.168.0.22 "~/refresh_web.sh 2 ${webs} ${mems}"
sleep 5

echo "Run 3" >> run.log
date >> run.log
./exp.sh etime_${webs}web_run3.log | tee exp_${mems}mem_${webs}web_run3.log
ssh -i ~/compass.pem ubuntu@192.168.0.22 "~/refresh_web.sh 3 ${webs} ${mems}"

echo "END" >> run.log
date >> run.log

