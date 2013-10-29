#Download JDK from Oracle - includes license agreement cookie
execute "download_OracleJDK" do
	cwd node.common.chef_cache
  	command "wget --no-cookies --header \"Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com\" \"#{node.jdk.url}\""
    creates "#{node.common.chef_cache}/#{node.jdk.filename}"
end

#Make target JVM dir
directory "#{node.jdk.install_dir}" do
	recursive true
end

#Untar the JDK
execute "untar_JDK" do
 	cwd node.jdk.install_dir
 	command "tar zxf #{node.common.chef_cache}/#{node.jdk.filename}"
 	creates "#{node.jdk.install_dir}/#{node.jdk.name}"
 	action :run
end

#Symlink JVM
link "#{node.jdk.install_dir}/java-7-sun" do
  to "#{node.jdk.install_dir}/#{node.jdk.name}"
end

#Expand the .jinfo file
template "#{node.jdk.install_dir}/.java-7-sun.jinfo" do
	source "java-7-sun.jinfo.erb"
	mode "444"
end

#Expand the registration script
template "#{node.jdk.install_dir}/register-jdk7.sh" do 
	source "register-jdk7.sh.erb"
	mode "755"
end 

#Execute the script to register the JDK with the OS
execute "run register-jdk7-vagrant.sh" do
	command "#{node.jdk.install_dir}/register-jdk7.sh"
	action :run
end

#Install java-common
apt_package "java-common" do
	action :install
end

#Update java alternatives
execute "update_java_alternatives" do
	command "update-java-alternatives -s java-7-sun"
	action :run
end

#Import the cert
execute "import server certificate" do
	cwd "#{node.jdk.install_dir}/java-7-sun/jre/lib/security"
	command "keytool -importkeystore -destkeystore cacerts -srckeystore #{node.common.chef_cache}/keystore.p12 -srcstoretype pkcs12 -alias #{node.common.key_alias} -srcstorepass changeit -deststorepass changeit; touch ./cert.updated"
	action :run
	creates "./cert.updated"
end