#!/bin/sh
wc=1800
pmc=75
mems=1
sed -i 's/webs=.*/webs=1/' run.sh
cp exp1.sh exp.sh
ssh -i ~/compass.pem ubuntu@192.168.0.22 'sudo cp ~/default1 /etc/nginx/sites-enabled/default'
ssh -i ~/compass.pem ubuntu@192.168.0.22 'sudo service nginx stop'
ssh -i ~/compass.pem ubuntu@192.168.0.22 'sudo service nginx start'
ssh -i ~/compass.pem ubuntu@192.168.0.22 'sudo service nginx status'
./run.sh ${mems} ${wc} ${pmc}
./restart_webs.sh

sed -i 's/webs=.*/webs=2/' run.sh
cp exp2.sh exp.sh
ssh -i ~/compass.pem ubuntu@192.168.0.22 'sudo cp ~/default2 /etc/nginx/sites-enabled/default'
ssh -i ~/compass.pem ubuntu@192.168.0.22 'sudo service nginx stop'
ssh -i ~/compass.pem ubuntu@192.168.0.22 'sudo service nginx start'
ssh -i ~/compass.pem ubuntu@192.168.0.22 'sudo service nginx status'
./run.sh ${mems} ${wc} ${pmc}
./restart_webs.sh

sed -i 's/webs=.*/webs=3/' run.sh
cp exp3.sh exp.sh
ssh -i ~/compass.pem ubuntu@192.168.0.22 'sudo cp ~/default3 /etc/nginx/sites-enabled/default'
ssh -i ~/compass.pem ubuntu@192.168.0.22 'sudo service nginx stop'
ssh -i ~/compass.pem ubuntu@192.168.0.22 'sudo service nginx start'
ssh -i ~/compass.pem ubuntu@192.168.0.22 'sudo service nginx status'
./run.sh ${mems} ${wc} ${pmc}
./restart_webs.sh


