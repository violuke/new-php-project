# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	# Every Vagrant virtual environment requires a box to build off of
	config.vm.box = "ubuntu/trusty64"

	# Fix symlink issue - https://github.com/mitchellh/vagrant/issues/713
	config.vm.provider "virtualbox" do |v|
		v.memory = 2048
		v.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
	end

	# Define ansible vagrant box
	config.vm.define "ansible" do |ansible|
		ansible.vm.network :private_network, ip: "10.0.60.2"
		ansible.vm.synced_folder ".", "/vagrant"
		ansible.vm.provision "shell", path: "vagrantProvisioning/ansible.sh"
	end

	# How other boxes will work needs thinking about
    # Define web vagrant box
    #config.vm.define "web" do |web|
    #	web.vm.network :private_network, ip: "10.0.60.3"
    #	web.vm.synced_folder ".", "/vagrant", id: "vagrant-root", owner: "vagrant", group: "www-data", mount_options: ["dmode=775,fmode=664"]
    #	web.vm.provision "shell", path: "vagrantProvisioning/web.sh"
    #end
end