#!/usr/bin/ruby

##
# Registers an instance with a Amazon elstic load balancer
# 
##

require 'rubygems'
require 'aws-sdk'

ACCESS_KEY_ID     = '<YOUR_ACCESS_KEY>'
SECRET_ACCESS_KEY = '<YOUR_SECRET_ACCESS_KEY>'
ELB_ENDPOINT		  = 'elasticloadbalancing.eu-west-1.amazonaws.com'

def register_node(node_id, balancer_name)
    
  raise 'unknown node' unless node_id
  raise 'unknown balancer' unless balancer_name

  begin
    elb = AWS::ELB.new(:access_key_id => ACCESS_KEY_ID, 
      :secret_access_key => SECRET_ACCESS_KEY, 
      :elb_endpoint => ELB_ENDPOINT)
    
    elb.load_balancers[balancer_name].instances.register(node_id)

    return 0
  rescue Exception => msg
    puts msg
    return 1
  end
end

register_node(ARGV[0], ARGV[1])