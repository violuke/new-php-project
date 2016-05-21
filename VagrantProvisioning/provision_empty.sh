#!/usr/bin/env bash

function echo_title {
	echo -e "\e[44m\e[97m-- $1 --\e[49m\e[39m"
}

echo_title "Copying SSH keys into place"
mkdir -p /home/vagrant/.ssh/
cat /vagrant/Private/SSHKeys/development.pub >> /home/vagrant/.ssh/authorized_keys
chmod 700 /home/vagrant/.ssh
chmod 600 /home/vagrant/.ssh/authorized_keys

echo_title "Installing bear minimum packages to use Ansible"
sudo apt-get install -y python python-apt

echo_title "Upgrading all packages"
sudo apt-get upgrade -y