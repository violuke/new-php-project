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
sudo ln -s /vagrant/Ansible /etc/ansible

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

cp /vagrant/Private/SSHKeys/development /home/vagrant/.ssh/development
chmod 600 /home/vagrant/.ssh/development

if [ -f /vagrant/Private/SSHKeys/known_hosts ]; then
	ln -s /vagrant/Private/SSHKeys/known_hosts /home/vagrant/.ssh/known_hosts
	chmod 600 /home/vagrant/.ssh/known_hosts
fi

echo_title "Installing whois package to provide mkpass command"
sudo apt-get install -y whois

echo_title "Installing debops"
sudo apt-get -y install python-pip
sudo pip install debops

echo_title "Installing other debops dependencies"
sudo pip install netaddr passlib
sudo apt-get install uuid-runtime encfs git python-dev

echo_title "Downloading debops packages"
debops-update

echo_title "Installing docker"
sudo apt-get install apt-transport-https ca-certificates
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
RELEASECODENAME="$(lsb_release --codename -s)"
sudo add-apt-repository "deb https://apt.dockerproject.org/repo ubuntu-$RELEASECODENAME main"
sudo apt-get update
sudo apt-get purge lxc-docker # Purge the old repo if it exists.
sudo apt-get install -y linux-image-extra-$(uname -r)
sudo apt-get install -y apparmor docker-engine

echo_title "Install docker compose"
sudo apt-get -y install python-pip
sudo pip install docker-compose

echo_title "Setting up docker group and adding the vagrant user to it"
sudo groupadd docker
sudo usermod -aG docker vagrant

echo_title "Copying SSH keys into build dir so they can be used"
cp /vagrant/Private/SSHKeys/development.pub /vagrant/VagrantProvisioning/development.pub

echo_title "Build docker network, bring up docker containers and attach them to it"
cd /vagrant/VagrantProvisioning
docker network create violuke-local
docker-compose up -d
docker run -it --publish-service web1.violuke-local web1
docker run -it --publish-service db1.violuke-local db1
#docker run -it --publish-service db2.violuke-local db2
#docker run -it --publish-service db3.violuke-local db3
#docker run -it --publish-service db4.violuke-local db4

echo_title "Removing copied SSH keys again after use"
rm -f /vagrant/VagrantProvisioning/development.pub

echo_title "Upgrading all packages"
sudo apt-get upgrade -y