#!/usr/bin/env bash

useradd -G www-data deploy
mkdir /home/deploy
usermod -s /bin/bash deploy
cp /root/.bashrc /home/deploy/.bashrc
chmod +x /home/deploy/.bashrc
chown deploy:deploy /home/deploy -R

# Grant deploy user access to restart php5-fpm and nginx
echo "deploy ALL = NOPASSWD: /usr/sbin/service php7.0-fpm *" >> /etc/sudoers
echo "deploy ALL = NOPASSWD: /usr/sbin/service nginx *" >> /etc/sudoers
echo "deploy ALL = NOPASSWD: /usr/bin/supervisorctl *" >> /etc/sudoers
