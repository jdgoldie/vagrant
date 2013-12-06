#
# Downloads and installs zookeeper7 to user directory, chowns dirs/files, sets up symlink as zookeeper
#

#Download zookeeper
execute "download_zookeeper_#{node.zookeeper.version}" do
	cwd node.common.chef_cache
  	command <<-EOF
    	wget --no-cookies "#{node.zookeeper.url}"
    EOF
    creates "#{node.common.chef_cache}/#{node.zookeeper.name}.tar.gz"
end

#Untar zookeeper
execute "untar_zookeeper" do	
 	cwd node.common.home_dir
 	command "tar zxf #{node.common.chef_cache}/#{node.zookeeper.name}.tar.gz"
 	creates "#{node.common.home_dir}/#{node.zookeeper.name}"
 	action :run
end

#chown the files
execute "chown_zookeeper" do
	command "chown -R vagrant:vagrant #{node.common.home_dir}/#{node.zookeeper.name}"
end

# Symlink ~/vagrant/zookeeper to apache-zookeeper-* directory
link "#{node.common.home_dir}/zookeeper" do
	to "#{node.common.home_dir}/#{node.zookeeper.name}"
	user "vagrant"
	group "vagrant"
end

# Update the zoo.cfg file
template "/vagrant/zoo.cfg" do
	source "zoo.cfg.erb"
	owner "vagrant"
	group "vagrant"
	mode "0644"
	variables({
		:host_entries => node["all_hosts_names"],
		:domain => node["common"]["domain"]
		})
end

#Copy the config file to the zookeeper dir
execute "copy_zookeeper_config_file" do
  command "cp /vagrant/zoo.cfg #{node.common.home_dir}/zookeeper/conf/zoo.cfg"
end

#Create the myid file
execute "create_myid_file" do
  command "echo #{node.common.myid} > #{node.common.home_dir}/zookeeper/myid"
end


# #service def for zookeeper
service "zookeeper" do
	supports :start => true, :stop =>true, :restart => true
	start_command "#{node.common.home_dir}/zookeeper/bin/zkServer.sh start"
        restart_command "#{node.common.home_dir}/zookeeper/bin/zkServer.sh stop; #{node.common.home_dir}/zookeeper/bin/zkServer.sh start"
 	stop_command "#{node.common.home_dir}/zookeeper/bin/zkServer.sh start"
 	action [:nothing]
end

# #Have it start when all is done
execute "start_zookeeper" do
	command "sleep 0" 
	notifies :start, 'service[zookeeper]', :delayed
end
