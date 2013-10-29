#
# Start the tomcat server
#
execute "start tomcat" do
 	cwd node.common.home_dir
 	command "tomcat/bin/startup.sh"
 	action :run
end