#!/usr/bin/env bash

if [[ $1 == "" ]]; then
    echo "You must specify an IP to deploy to, eg. './install.sh 192.168.0.1'"
    exit 1
fi

ssh root@$1 'rm -R /root/provision'
scp -r ./ root@$1:/root/provision

ssh root@$1 '/root/provision/provision/create_deploy_user.sh'
ssh root@$1 '/root/provision/provision/install_services.sh'

ssh root@$1 'rm -R /root/provision'
