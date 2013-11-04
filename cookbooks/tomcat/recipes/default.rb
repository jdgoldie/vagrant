#
# Downloads and installs tomcat7 to user directory, chowns dirs/files, sets up symlink as tomcat
#

#Download Tomcat
execute "download_tomcat_#{node.tomcat.version}" do
	cwd node.common.chef_cache
  	command <<-EOF
    	wget --no-cookies "#{node.tomcat.url}"
    EOF
    creates "#{node.common.chef_cache}/#{node.tomcat.name}.tar.gz"
end

#Untar Tomcat
execute "untar_tomcat" do	
 	cwd node.common.home_dir
 	command "tar zxf #{node.common.chef_cache}/#{node.tomcat.name}.tar.gz"
 	creates "#{node.common.home_dir}/#{node.tomcat.name}"
 	action :run
end

#chown the files
execute "chown_tomcat" do
	command "chown -R vagrant:vagrant #{node.common.home_dir}/#{node.tomcat.name}"
end

# Symlink ~vagrant/tomcat to apache-tomcat-* directory
link "#{node.common.home_dir}/tomcat" do
	to "#{node.common.home_dir}/#{node.tomcat.name}"
	user "vagrant"
	group "vagrant"
end

# Enable user for management apps
template "#{node.common.home_dir}/tomcat/conf/tomcat-users.xml" do
	source "tomcat-users.xml.erb"
	owner "vagrant"
	group "vagrant"
end

# server.xml file for SSL
template "#{node.common.home_dir}/tomcat/conf/server.xml" do
	source "server.xml.erb"
	owner "vagrant"
	group "vagrant"
	variables({
     	:cacerts_path => "/usr/lib/jvm/java-7-sun/jre/lib/security/cacerts"
    })
end

#startup/shutdown files
template "#{node.common.home_dir}/tomcat/bin/startup.sh" do
	source "startup.sh.erb"
	owner "vagrant"
	group "vagrant"
	mode "0755"
	variables ({
		:home_dir => "#{node.common.home_dir}"
		})
end

template "#{node.common.home_dir}/tomcat/bin/shutdown.sh" do
	source "shutdown.sh.erb"
	owner "vagrant"
	group "vagrant"
	mode "0755"
	variables ({
		:home_dir => "#{node.common.home_dir}"
		})
end

#service def for tomcat
service "tomcat" do
 	supports :start => true, :stop =>true, :restart => true
	start_command "#{node.common.home_dir}/tomcat/bin/startup.sh"
	restart_command "#{node.common.home_dir}/tomcat/bin/shutdown.sh; #{node.common.home_dir}/tomcat/bin/startup.sh"
	stop_command "#{node.common.home_dir}/tomcat/bin/shutdown.sh"
	action [:nothing]
end

#Have it start when all is done
execute "start_tomcat" do
	command "sleep 0" 
	notifies :start, 'service[tomcat]', :delayed
end
