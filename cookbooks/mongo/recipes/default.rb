#
# Install mongodb
#

#Key for 10gen repo
execute "Adding key for 10gen Repo" do 
	command "apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10; touch #{node.common.chef_cache}/10gen.key.downloaded"
	action :run
	creates "#{node.common.chef_cache}/10gen.key.downloaded"
end

#Create sources.list.d/mongodb.list
template "/etc/apt/sources.list.d/mongodb.list" do
	source "mongodb.list.erb"
	owner "root"
	group "root"	
end

# Apt-get update to refresh list
execute "apt-get update" do
	action :run
end

# Install mongo
apt_package "mongodb" do 
	action :install
end
