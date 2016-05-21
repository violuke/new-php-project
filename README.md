# New PHP Project
This is a great starting point for all new PHP projects. It will help you configure a development
environment and also your production environment to the same spec.

# NOTE: This is a work in progress so I suggest you don't use it yet

## Getting started
1. Clone this repo `git clone git@github.com:violuke/new-php-project.git`
2. Build your vagrant box and SSH to it, by running `vagrant up && vagrant ssh`
3. Modify Ansible config as required (such as for your domain name). Set up DNS (or edit hosts file) to point your domain to `10.0.60.2`
    1. Set your own timezone in `VagrantProvisioning/debops/ansible/inventory/group_vars/all/ntp.yml`
    2. Set your domain in `VagrantProvisioning/debops/ansible/inventory/group_vars/all/bootstrap.yml`
4. Within the Vagrant box, run `cd /vagrant/VagrantProvisioning/debops/ansible/ && debops bootstrap --user vagrant` to configure all the web and db docker contains, just as they would be in production.
5. When you want to publish your project to production, get your hosts file updated and run `TBC`

## Configuring your production servers
1. Configure your hosts
2. At this point you most likely have to connect to that host using the root account and specifying a password.
To make that easier, you can use a special "bootstrap" Ansible playbook to prepare a host for easier management.
To do this, execute the command: `debops bootstrap --limit server --user root --ask-pass`

## TODO:
1. Git crypt & security
2. Completed instructions