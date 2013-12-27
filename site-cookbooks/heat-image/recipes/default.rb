#
# Cookbook Name:: heat-image
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'yum::epel'

%w{cloud-init heat-cfntools}.each do |pkg|
  package pkg do
    action :install
  end
end
