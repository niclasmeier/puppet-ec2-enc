#!/usr/bin/ruby

##
# Classifies a puppet node based on its EC2 security groups and EC2 tags.
# Requires the aws-sdk and yaml gem.
# Also requires a node_groups.yml file which specifies security groups
# and the classes/params that should be applied, in the following
# format (additionally keyed by security group name).
# http://docs.puppetlabs.com/guides/external_nodes.html
#
# To use this script, add the following two lines to your puppet.conf:
# node_terminus = exec
# external_nodes = /path/to/ec2_enc.rb
##

require 'rubygems'
require 'yaml'
require 'logger'
require 'aws-sdk'


ACCESS_KEY_ID     = '<YOUR_ACCESS_KEY>'
SECRET_ACCESS_KEY = '<YOUR_SECRET_ACCESS_KEY>'
NODE_GROUPS_YAML  = '/etc/puppet/node_groups.yml'
EC2_ENDPOINT		  = 'eu-west-1.ec2.amazonaws.com'


def find_instance(host_name)

  if (not host_name)
    puts 'Usage: ec2_enc.rb <host_name>'
    puts 'The parameter host_name must not be empty'
    exit 1
  end

  node_groups = YAML::load( File.open( NODE_GROUPS_YAML ) )

  ec2 = AWS::EC2.new(:access_key_id => ACCESS_KEY_ID, 
     :secret_access_key => SECRET_ACCESS_KEY,
     :ec2_endpoint => EC2_ENDPOINT)

  ec2.instances.filter('private-dns-name', host_name).each do |instance|

    base = Hash.new
    instance.security_groups.each do | group|
      base = base.merge(node_groups.fetch(group.name, Hash.new)) 
    end    

    tags = Hash.new
    instance.tags.each do |key, value|
      tags['ec2_tag_'+key] = value
    end 

    base['parameters'] = base.fetch('parameters', Hash.new).merge(tags) unless tags.empty?

    return base.to_yaml
  end

  puts "Unknown host with name #{host_name}."
  exit 1
end


puts find_instance(ARGV[0])