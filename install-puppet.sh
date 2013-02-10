#!/bin/bash
set -e -x
export DEBIAN_FRONTEND=noninteractive

echo "Adding Puppetlabs repository..."
curl -o /tmp/puppetlabs-release-precise.deb http://apt.puppetlabs.com/puppetlabs-release-precise.deb
dpkg -i /tmp/puppetlabs-release-precise.deb

echo "Updating APT repositories..."
apt-get update && apt-get upgrade -y

echo "Installing puppet and facter..."
sudo apt-get install puppet facter -y

echo "Wrinting puppet conf..."
(cat <<"END"
[main]
logdir=/var/log/puppet
vardir=/var/lib/puppet
ssldir=/var/lib/puppet/ssl
rundir=/var/run/puppet
factpath=$vardir/lib/facter
templatedir=$confdir/templates
server=puppetmaster.example.com
END
) > /etc/puppet/puppet.conf

echo "Enabling autostart for Puppet..."
cat /etc/default/puppet | sed s/START=no/START=yes/g > /etc/default/puppet.tmp && mv /etc/default/puppet.tmp /etc/default/puppet

echo "Stating Puppet ..."
service puppet start