#
# Cookbook Name:: redmine
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
git "/var/redmine" do
  repository "git://github.com/redmine/redmine.git"
  reference "master"
  action :checkout
  user "root"
  group "root"
end
