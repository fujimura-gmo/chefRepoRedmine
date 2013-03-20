#
# Cookbook Name:: unicorn
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
gem_package 'unicorn' do
  action :install
end

#template "unicorn.rb" do
#  path ""
#  source "unicorn.rb.erb"
#  owner "root"
#  group "root"
#  mode 0644
#end
