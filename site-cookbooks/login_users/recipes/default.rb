#
# Cookbook Name:: login_users
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
data_ids = data_bag('users')

data_ids.each do |id|
  u = data_bag_item('users', id)
  user u['username'] do
    home u['home']
    shell u['shell']
  end
end
