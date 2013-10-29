#link the webapp dir to extenral sync dir under /vagrant...
execute "move_default_webapps" do
	command "mv #{node.webapp.tomcat_dir} #{node.webapp.tomcat_dir}_old"
end

directory "#{node.webapp.linked_dir}" do
	action :create
	user "vagrant"
	group "vagrant"
end

link "#{node.webapp.tomcat_dir}" do
	to "#{node.webapp.linked_dir}"
	user "vagrant"
	group "vagrant"
end

execute "copy defaults" do
	command "cp -r #{node.webapp.tomcat_dir}_old/* #{node.webapp.linked_dir}/"
end
