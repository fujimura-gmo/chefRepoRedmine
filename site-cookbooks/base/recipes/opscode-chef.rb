
template "bashprofile_opscode-chef.sh" do
  path "/etc/profile.d/opscode-chef.sh"
  source "opscode-chef.sh.erb"
  owner "root"
  group "root"
  mode 0644
  #notifies :reload, 'service[nginx]'
end
