require 'fog'
require 'pp'

conn = Fog::Compute.new({
  :provider => 'OpenStack',
  :openstack_api_key => ENV['OS_PASSWORD'],
  :openstack_username => ENV['OS_USERNAME'],
  :openstack_auth_url => ENV['OS_AUTH_URL'] + '/tokens',
  :openstack_tenant => ENV['OS_TENANT_NAME']
})

server = conn.servers.create :name => "fogvm-#{Time.now.strftime '%Y%m%d-%H%M%S'}",
                             :image_ref => 'd58ca966-b515-4ce4-8634-d3084b0a1433',
                             :flavor_ref => 1,
                             :key_name => ENV['KEY_NAME']
server.wait_for { ready? }

target_ip = server.addresses['net_itsolab'].last['addr']
p(target_ip)

#sleep(60)
while true 
  system("knife solo prepare  --ssh-user root -i #{ENV['SSH_IDENTITYFILE']} " + target_ip)
  if $? == 0
    break
  end
  p("error sleep 10 sec")
  sleep(10)
end

#system("cp nodes/fog_melody.json nodes/" + target_ip + '.json')
system("sed \'s/localhost/" + server.name + "/\' nodes/fog_melody.json > nodes/" + target_ip + '.json')
system("knife solo cook  --ssh-user root -i #{ENV['SSH_IDENTITYFILE']} " + target_ip)
