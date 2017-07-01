#!/bin/sh
#wc=1800
#pmc=75
mems=3
#sed -i 's/webs=.*/webs=1/' run.sh
#cp exp1.sh exp.sh
#ssh -i ~/compass.pem ubuntu@192.168.0.22 'sudo cp ~/default1 /etc/nginx/sites-enabled/default'
#ssh -i ~/compass.pem ubuntu@192.168.0.22 'sudo service nginx stop'
#ssh -i ~/compass.pem ubuntu@192.168.0.22 'sudo service nginx start'
#ssh -i ~/compass.pem ubuntu@192.168.0.22 'sudo service nginx status'
#ssh -i ~/compass.pem ubuntu@192.168.0.22 'sudo cp ~/apache1web.conf /etc/apache2/apache2.conf'
#ssh -i ~/compass.pem ubuntu@192.168.0.22 'sudo service apache2 stop'
#ssh -i ~/compass.pem ubuntu@192.168.0.22 'sudo service apache2 start'
#ssh -i ~/compass.pem ubuntu@192.168.0.22 'sudo service apache2 status'
#./run.sh ${mems} ${wc} ${pmc}
#./run.sh ${mems}
#./restart_webs_nginx.sh

#sed -i 's/webs=.*/webs=2/' run.sh
#cp exp2.sh exp.sh
#ssh -i ~/compass.pem ubuntu@192.168.0.22 'sudo cp ~/default2 /etc/nginx/sites-enabled/default'
#ssh -i ~/compass.pem ubuntu@192.168.0.22 'sudo service nginx stop'
#ssh -i ~/compass.pem ubuntu@192.168.0.22 'sudo service nginx start'
#ssh -i ~/compass.pem ubuntu@192.168.0.22 'sudo service nginx status'
#ssh -i ~/compass.pem ubuntu@192.168.0.22 'sudo cp ~/apache2web.conf /etc/apache2/apache2.conf'
#ssh -i ~/compass.pem ubuntu@192.168.0.22 'sudo service apache2 stop'
#ssh -i ~/compass.pem ubuntu@192.168.0.22 'sudo service apache2 start'
#ssh -i ~/compass.pem ubuntu@192.168.0.22 'sudo service apache2 status'
#./run.sh ${mems} ${wc} ${pmc}
#./run.sh ${mems}
#./restart_webs_nginx.sh

sed -i 's/webs=.*/webs=3/' run.sh
cp exp3.sh exp.sh
ssh -i ~/compass.pem ubuntu@192.168.0.22 'sudo cp ~/default3 /etc/nginx/sites-enabled/default'
ssh -i ~/compass.pem ubuntu@192.168.0.22 'sudo service nginx stop'
ssh -i ~/compass.pem ubuntu@192.168.0.22 'sudo service nginx start'
ssh -i ~/compass.pem ubuntu@192.168.0.22 'sudo service nginx status'
#ssh -i ~/compass.pem ubuntu@192.168.0.22 'sudo cp ~/apache3web.conf /etc/apache2/apache2.conf'
#ssh -i ~/compass.pem ubuntu@192.168.0.22 'sudo service apache2 stop'
#ssh -i ~/compass.pem ubuntu@192.168.0.22 'sudo service apache2 start'
#ssh -i ~/compass.pem ubuntu@192.168.0.22 'sudo service apache2 status'
#./run.sh ${mems} ${wc} ${pmc}
./run.sh ${mems}
./restart_webs_apache.sh


