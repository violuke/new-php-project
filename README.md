# new-php-project
This is a great starting point for all new PHP projects.

# Getting started
1. Clone this repo `git clone XXX`
2. Build your vagrant box and SSH to it, by running `vagrant up && vagrant ssh`
3. Modify Ansible config as required (such as for your domain name). Set up DNS (or edit hosts file) to point your domain to `10.0.60.2`
4. Within the Vagrant box, run `cd XXX` to configure all the web and db docker contains, just as they would be in production.
5. When you want to publish your project to production, get your hosts file updated and run `TBC`

# TODO:
1. Git crypt & security
2. Completed instructions