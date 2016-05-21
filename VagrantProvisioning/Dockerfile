# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/baseimage

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Ensure we're up to date
RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"

# Install python so Ansible can run on it
RUN apt-get install -y python python-simplejson

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*