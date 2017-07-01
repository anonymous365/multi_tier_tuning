#!/bin/sh

ssh -i ~/compass.pem ubuntu@192.168.0.45 'sudo service apache2 stop';
ssh -i ~/compass.pem ubuntu@192.168.0.45 'sudo service apache2 start';
ssh -i ~/compass.pem ubuntu@192.168.0.45 'sudo service apache2 status';

ssh -i ~/compass.pem ubuntu@192.168.0.28 'sudo service apache2 stop';
ssh -i ~/compass.pem ubuntu@192.168.0.28 'sudo service apache2 start';
ssh -i ~/compass.pem ubuntu@192.168.0.28 'sudo service apache2 status';

ssh -i ~/compass.pem ubuntu@192.168.0.29 'sudo service apache2 stop';
ssh -i ~/compass.pem ubuntu@192.168.0.29 'sudo service apache2 start';
ssh -i ~/compass.pem ubuntu@192.168.0.29 'sudo service apache2 status';
sleep 1;

