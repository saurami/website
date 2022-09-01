#! /bin/bash

sudo apt update

sudo snap install core
sudo snap refresh core

sudo apt install apache2 -y
sudo service apache2 status

sudo snap remove certbot
sudo apt remove certbot -y
sudo unlink /usr/bin/certbot

sudo snap install --classic certbot
sudo ln -s $(which certbot) /usr/bin/certbot
readlink -f /snap/bin/certbot

sudo mkdir -p /var/www/saurabh.cc/playground
sudo mkdir -p /var/www/saurabh.cc/public_html

sudo cp /home/saurabh/index.html /var/www/saurabh.cc/playground/
sudo cp /home/saurabh/index.html /var/www/saurabh.cc/public_html/
sudo cp /home/saurabh/saurabh.cc.conf /etc/apache2/sites-available/

sudo a2ensite saurabh.cc.conf
sudo a2dissite 000-default.conf
sudo systemctl reload apache2
sudo a2query -s

sudo service apache2 restart
sudo service apache2 status

sudo certbot --apache --non-interactive \
	--email "saurabhm@proton.me" \
	--agree-tos \
	--no-eff-email \
	--domain "saurabh.cc" --domain "www.saurabh.cc"
