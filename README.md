# Readme

This repository is used to track *all* software or configuration changes deployed to this server.

## Software

- PHP 7.0
- Nginx
- MySQL
- Redis
- Supervisor
- Git
- Composer

## Usage

- Web applications should be stored in `/opt`
- Files found matching `/opt/*/nginx.conf` will be automatically included by Nginx's config
- Files found matching `/opt/*/supervisor/*.conf` will be automatically included by Supervisor's config
- Files found matching the following paths will be executed at the expected intervals using cron:
    - `/opt/*/cron/minutely` 
    - `/opt/*/cron/hourly` 
    - `/opt/*/cron/daily` 
    - `/opt/*/cron/weekly` 
    - `/opt/*/cron/monthly` 
- A default site is included at `/opt/000-default.com`

## Provisioning

1. Boot up a new Ubuntu server
2. Open any applicable network firewall ports and copy your public key to the root user on the server
3. From your local machine, run `./install.sh {server IP}`

## Deploying

During server provisioning, a new SSH user named "deploy" is created which can be used for deploying websites. For access, you should SSH as root and set a new password for that user, or manually add your public key to `/home/deploy/.ssh/authorized_keys`

## Usage in your local Vagrant box

You can require this using repository using Composer

    composer require adamnicholson/server01 --dev


Then you might want a `Vagrantfile` in your project that looks something like this

```
Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty32"

  # Provision the Vagrant box
  config.vm.provision "shell", inline: "sudo ln -s /vagrant/vendor/adamnicholson/server01 /root/provision"
  config.vm.provision "shell", inline: "sudo /vagrant/vendor/adamnicholson/server01/provision/install_services.sh"
  config.vm.provision "shell", inline: "sudo /vagrant/vendor/adamnicholson/server01/provision/install_services_dev.sh"

  # "Deploy" the site to the Vagrant box
  config.vm.provision "shell", inline: "sudo rm -R /opt/000-default.com/*"
  config.vm.provision "shell", inline: "sudo ln -s /vagrant /opt/000-default.com/current"
  config.vm.provision "shell", inline: "sudo ln -s /opt/000-default.com/current/nginx.conf /opt/000-default.com/nginx.conf"
  config.vm.provision "shell", inline: "sudo service nginx reload"
end
```
