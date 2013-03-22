package "zabbix-agent" do
  action :install
end

service 'zabbix-agent' do
  supports :status => true, :restart => true
  action [ :enable, :start ]
end

template "zabbix_agentd.conf" do
  path "/etc/zabbix/zabbix_agentd.conf"
  source "zabbix_agentd.conf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, 'service[zabbix-agent]'
end
