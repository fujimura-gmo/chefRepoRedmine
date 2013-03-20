#
# Cookbook Name:: redmine
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
git "/var/lib/redmine" do
  repository "git://github.com/redmine/redmine.git"
  reference "master"
  action :checkout
  user "root"
  group "root"
end

bash "mysql-setting" do
  code <<-EOC
    echo "CREATE DATABASE redmine DEFAULT CHARACTER SET utf8;" | mysql -uroot -piloverandompasswordsbutthiswilldo;
    echo "GRANT ALL ON redmine.* TO redmine@'localhost' IDENTIFIED BY 'redmine';" | mysql -uroot -piloverandompasswordsbutthiswilldo;
    echo "FLUSH PRIVILEGES;" | mysql -uroot -piloverandompasswordsbutthiswilldo;
  EOC
end

template "database.yml" do
  path "/var/lib/redmine/config/database.yml"
  source "database.yml.erb"
  owner "root"
  group "root"
  mode 0644
end

gem_package 'bundler' do
  action :install
end

bash "exec-bundle" do
  code <<-EOC
    cd /var/lib/redmine;
    bundle install --without development test rmagick;
  EOC
end

bash "generate_secret_token" do
  code <<-EOC
    cd /var/lib/redmine;
    rake generate_secret_token
  EOC
end

bash "db-migrate" do
  code <<-EOC
    cd /var/lib/redmine;
    RAILS_ENV=production rake db:migrate
  EOC
end

#bash "load-default-data" do
#  code <<-EOC
#    cd /var/lib/redmine;
#    RAILS_ENV=production rake redmine:load_default_data
#  EOC
#end
