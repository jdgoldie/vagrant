#
# Downloads and installs tomcat7 to user directory, chowns dirs/files, sets up symlink as tomcat
#

#Download Tomcat
execute "download_cas_#{node.cas.version}" do
	cwd node.common.chef_cache
  	command <<-EOF
    	wget --no-cookies "#{node.cas.url}"
    EOF
    creates "#{node.common.chef_cache}/#{node.cas.name}-release.tar.gz"
end

#Untar CAS
execute "untar_cas" do	
 	cwd node.common.home_dir
 	command "tar zxf #{node.common.chef_cache}/#{node.cas.name}-release.tar.gz"
 	creates "#{node.common.home_dir}/#{node.cas.name}"
 	action :run
end

#Create CAS dir
directory "#{node.common.home_dir}/tomcat/webapps/cas" do
  owner "vagrant"
  group "vagrant"
  mode "0644"
  action :create
end

#Unjar cas-server-webapp
execute "unjar_cas-server-webapp" do
	cwd "#{node.common.home_dir}/tomcat/webapps/cas"
	command "jar -xvf #{node.common.home_dir}/#{node.cas.name}/modules/cas-server-webapp-#{node.cas.version}.war"
end

#Set up cas.properties
template "#{node.common.home_dir}/tomcat/webapps/cas/WEB-INF/cas.properties" do
	source "cas.properties.erb"
	owner "vagrant"
	group "vagrant"
  mode "0644"	
	variables({
     	:cas_host => "#{node.server}.#{node.common.domain}"
    })	
end