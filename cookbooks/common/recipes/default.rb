#Create a cache for downloads so the do not have to be done twice
directory "#{node.common.chef_cache}" do
	recursive true
end

#
# Installs wget for use in other chef recipes
#
apt_package "wget" do 
	action :install
end

#
# Generates an SSL key for this server
#

# Create script file from template
template "#{node.common.chef_cache}/makekey.sh" do
	source "makekey.sh.erb"
	owner "root"
	group "root"
	mode "755"
	variables({
     	:domain => "#{node.common.domain}",
     	:key_alias => "#{node.common.key_alias}"
    })
end

#Execute it
execute "run openssl script" do
	cwd node.common.chef_cache
	command "./makekey.sh"
	action :run
	creates "#{node.common.chef_cache}/keystore.p12"
end

file "#{node.common.chef_cache}/selfsigned.crt" do
	action :delete
end

file "#{node.common.chef_cache}/server.csr" do
	action :delete
end

file "#{node.common.chef_cache}/server.key" do
	action :delete
end
