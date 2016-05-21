#!/usr/bin/env bash

function echo_title {
	echo -e "\e[44m\e[97m-- $1 --\e[49m\e[39m"
}

echo_title "Installing Ansible"
sudo apt-get install software-properties-common
sudo apt-add-repository -y ppa:ansible/ansible
sudo apt-get update
sudo apt-get install -y ansible

echo_title "Installing Ansible task requirements"
sudo apt-get install python-netaddr

echo_title "Overriding Ansible Config"
sudo rm -rf /etc/ansible
sudo ln -s /vagrant/VagrantProvisioning/Ansible /etc/ansible

echo_title "Install required Ansible roles"
cd /etc/ansible
ansible-galaxy install -r requirements.yml

echo_title "Generating SSH keys if required"
if [ ! -f /vagrant/Private/SSHKeys/production ]; then
	ssh-keygen -t rsa -N "" -f /vagrant/Private/SSHKeys/production
fi
if [ ! -f /vagrant/Private/SSHKeys/development ]; then
	ssh-keygen -t rsa -N "" -f /vagrant/Private/SSHKeys/development
fi

echo_title "Copying SSH keys into place"
cp /vagrant/Private/SSHKeys/production /home/vagrant/.ssh/production
chmod 600 /home/vagrant/.ssh/production
chown vagrant:vagrant /home/vagrant/.ssh/production
echo "IdentityFile ~/.ssh/production" >> /home/vagrant/.ssh/config

cp /vagrant/Private/SSHKeys/development /home/vagrant/.ssh/development
chmod 600 /home/vagrant/.ssh/development
chown vagrant:vagrant /home/vagrant/.ssh/development
echo "IdentityFile ~/.ssh/development" >> /home/vagrant/.ssh/config

if [ -f /vagrant/Private/SSHKeys/known_hosts ]; then
	ln -s /vagrant/Private/SSHKeys/known_hosts /home/vagrant/.ssh/known_hosts
	chmod 600 /home/vagrant/.ssh/known_hosts
fi

chmod 700 /home/vagrant/.ssh/
chown vagrant:vagrant /home/vagrant/.ssh
chmod 600 /home/vagrant/.ssh/config
chown vagrant:vagrant /home/vagrant/.ssh/config

echo_title "Installing whois package to provide mkpass command"
sudo apt-get install -y whois

echo_title "Installing debops"
sudo apt-get -y install python-pip git
sudo pip install debops

echo_title "Installing other debops dependencies"
sudo pip install netaddr passlib
sudo apt-get -y install uuid-runtime encfs python-dev

echo_title "Downloading debops packages"
cd /vagrant/VagrantProvisioning/debops/ansible
debops-update

echo_title "Upgrading all packages"
sudo apt-get upgrade -y