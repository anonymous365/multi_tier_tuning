#!/bin/sh

ssh -i ~/compass.pem ubuntu@192.168.0.45 'sudo service nginx stop';
ssh -i ~/compass.pem ubuntu@192.168.0.45 'sudo service php5-fpm restart';
ssh -i ~/compass.pem ubuntu@192.168.0.45 'sudo service nginx start';
ssh -i ~/compass.pem ubuntu@192.168.0.45 'sudo service nginx status';

ssh -i ~/compass.pem ubuntu@192.168.0.28 'sudo service nginx stop';
ssh -i ~/compass.pem ubuntu@192.168.0.28 'sudo service php5-fpm restart';
ssh -i ~/compass.pem ubuntu@192.168.0.28 'sudo service nginx start';
ssh -i ~/compass.pem ubuntu@192.168.0.28 'sudo service nginx status';

ssh -i ~/compass.pem ubuntu@192.168.0.29 'sudo service nginx stop';
ssh -i ~/compass.pem ubuntu@192.168.0.29 'sudo service php5-fpm restart';
ssh -i ~/compass.pem ubuntu@192.168.0.29 'sudo service nginx start';
ssh -i ~/compass.pem ubuntu@192.168.0.29 'sudo service nginx status';
sleep 1;


#ssh -i ~/compass.pem ubuntu@192.168.0.29 "sudo sed -i 's/worker_connections [0-9]*/worker_connections ${wc}/' /etc/nginx/nginx.conf";
#ssh -i ~/compass.pem ubuntu@192.168.0.29 "sudo sed -i 's/pm.max_children = [0-9]*/pm.max_children = ${pmc}/' /etc/php5/fpm/pool.d/www.conf"

