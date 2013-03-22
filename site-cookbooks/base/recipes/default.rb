
execute 'hosts' do
  command "hostname #{node['base']['hostname']} "
  action :run
end

template "hosts" do
  path "/etc/hosts"
  source "hosts.erb"
  owner "root"
  group "root"
  mode 0644
  #notifies :reload, 'service[nginx]'
end

template "sysconfig-network" do
  path "/etc/sysconfig/network"
  source "network.erb"
  owner "root"
  group "root"
  mode 0644
  #notifies :reload, 'service[nginx]'
end
