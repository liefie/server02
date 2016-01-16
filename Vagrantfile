Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty32"

  config.vm.synced_folder "./", "/root/provision"

  config.vm.provision "shell", inline: "/root/provision/provision/create_deploy_user.sh"
  config.vm.provision "shell", inline: "/root/provision/provision/install_services.sh"

  config.vm.provider "virtualbox" do |v|
    v.memory = 512
    v.cpus = 1
  end
end
