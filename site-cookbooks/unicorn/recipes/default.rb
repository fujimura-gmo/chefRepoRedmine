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

template "unicorn.rb" do
  path "/var/lib/redmine/config/unicorn.rb"
  source "unicorn.rb.erb"
  owner "root"
  group "root"
  mode 0644
end

bash "run-unicorn" do
  not_if 'pgrep -f "unicorn_rails master"'
    code <<-EOC
      cd /var/lib/redmine;
      unicorn_rails -c config/unicorn.rb -E production -D
    EOC
end
