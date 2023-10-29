Vagrant.configure("2") do |config|
  config.vm.define "master" do |subconfig|
    subconfig.vm.box = "ubuntu/focal64"
    subconfig.vm.hostname = "master"
    subconfig.vm.network "private_network", type: "static", ip: "192.168.56.10"
#   subconfig.vm.provision "shell", path: "script.sh"
  end

  config.vm.define "slave" do |subconfig|
    subconfig.vm.box = "ubuntu/focal64"
    subconfig.vm.hostname = "slave"
    subconfig.vm.network "private_network", type: "static", ip: "192.168.56.11"
   end

  #Provisioning script
#  config.vm.provision "shell", path: "script.sh"


end

