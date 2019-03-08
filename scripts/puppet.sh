#!/bin/bash

# see: https://docs.puppet.com/puppet/latest/puppet_platform.html

# determine the os release
os_release=$(lsb_release -cs)

# configure the puppet package sources
wget "https://apt.puppet.com/puppet5-release-$os_release.deb"
dpkg -i "puppet5-release-$os_release.deb"
apt-get -q update

#Setup masterless mode
echo "[main]
logdir=/var/log/puppet
vardir=/var/lib/puppet
ssldir=/var/lib/puppet/ssl
rundir=/var/run/puppet
modulepath=/etc/puppet/code/modules" > /etc/puppet/puppet.conf

#set puppet to auto start
echo "Setting puppet to start on reboot"
puppet resource service puppet ensure=running enable=true
echo "Checking puppet version"
puppet --version
puppet master --version
puppet agent --version
read -p "Press enter to continue"
echo '# Defaults for puppet - sourced by /etc/init.d/puppet

# Start puppet on boot?
 START=yes

# Startup options
 DAEMON_OPTS=""' > /etc/default/puppet
read -p "Press enter to continue"
