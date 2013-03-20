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

bash "install-bundle" do
  code <<-EOC
    gem install bundler
  EOC
end

bash "exec-bundle" do
  code <<-EOC
    cd /var/lib/redmine;
    bundle exec install --path vendor/bundle --without development test postgresql sqlite;
  EOC
end

