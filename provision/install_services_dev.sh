#!/usr/bin/env bash

# Disable Nginx sendfile; it has issues when in a virtual vagrant environment
sudo sed -i 's/sendfile on/sendfile off/g' /etc/nginx/nginx.conf
