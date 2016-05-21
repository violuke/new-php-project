# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	# Every Vagrant virtual environment requires a box to build off of
	config.vm.box = "ubuntu/trusty64"

	# Fix symlink issue - https://github.com/mitchellh/vagrant/issues/713
	config.vm.provider "virtualbox" do |v|
		v.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
		v.linked_clone = true if Vagrant::VERSION =~ /^1.8/
		v.cpus = 1
	end

	config.vm.define "ansible" do |ansible|
	    ansible.vm.network :private_network, ip: "10.0.60.2"
	    ansible.vm.synced_folder ".", "/vagrant", id: "vagrant-root"
	    ansible.vm.provision "shell", path: "VagrantProvisioning/provision_ansible.sh"
	    ansible.vm.provider "virtualbox" do |v|
            v.memory = 256
        end
    end

	config.vm.define "web1" do |web1|
	    web1.vm.network :private_network, ip: "10.0.60.3"
	    web1.vm.synced_folder ".", "/vagrant", id: "vagrant-root"
	    web1.vm.provision "shell", path: "VagrantProvisioning/provision_empty.sh"
	    web1.vm.provider "virtualbox" do |v|
            v.memory = 2048
        end

    end

	config.vm.define "db1" do |db1|
	    db1.vm.network :private_network, ip: "10.0.60.4"
	    db1.vm.synced_folder ".", "/vagrant", id: "vagrant-root"
	    db1.vm.provision "shell", path: "VagrantProvisioning/provision_empty.sh"
	    db1.vm.provider "virtualbox" do |v|
            v.memory = 2048
        end
    end
end