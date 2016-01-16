#!/usr/bin/env bash

# Add third party ppa repositories
sudo add-apt-repository ppa:ondrej/php-7.0
sudo add-apt-repository ppa:nginx/stable
sudo apt-get update

# Install MySQL Server
sudo echo "mysql-server-5.5 mysql-server/root_password password password" | sudo debconf-set-selections
sudo echo "mysql-server-5.5 mysql-server/root_password_again password password" | sudo debconf-set-selections
sudo apt-get install -y mysql-server-5.5
mysqladmin -u root -ppassword password ''

sudo echo "[mysqld]" >> /etc/mysql/conf.d/my.cnf
sudo echo "sql_mode=STRICT_TRANS_TABLES" >> /etc/mysql/conf.d/my.cnf

# Install MySQL Client
sudo apt-get install -y mysql-client-5.5

# Install Nginx and PHP
sudo apt-get install -y nginx
sudo apt-get install -y php7.0 php7.0-common php7.0-cli php7.0-curl php7.0-json php7.0-mysql php7.0-sqlite3 php7.0-mcrypt php7.0-fpm

# Configure Nginx
sudo rm /etc/nginx/sites-enabled/default
sudo cp /root/provision/etc/nginx/nginx.conf /etc/nginx/nginx.conf
sudo rm /opt -R && sudo cp /root/provision/opt /opt -R

# Install Redis for cache
sudo mkdir /etc/redis
cd /etc/redis
sudo apt-get install build-essential -y
sudo apt-get install tcl8.5 -y
wget http://download.redis.io/releases/redis-stable.tar.gz
tar xzf redis-stable.tar.gz
cd redis-stable
make
sudo make install
cd utils
echo "" | sudo ./install_server.sh

# Install Supervisor for long running process management
sudo apt-get install supervisor -y
sudo cp -f /root/provision/etc/supervisor/supervisord.conf /etc/supervisor/supervisord.conf
sudo supervisorctl reread
sudo supervisorctl update

# Install Crontab
sudo crontab /root/provision/provision/crontab

# Install build tools
sudo wget -O /usr/local/bin/composer https://getcomposer.org/composer.phar
sudo chmod +x /usr/local/bin/composer
sudo apt-get install git -y

# Restart all the things
sudo service php7.0-fpm restart && sudo service nginx restart
