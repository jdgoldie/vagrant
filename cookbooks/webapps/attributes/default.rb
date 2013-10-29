#
# Attributes for webapps recipe
#

include_attribute "common"

# Target linked webapp dir
default["webapp"]["linked_dir"] = "/vagrant/#{node.webapps}"

# Tomcat webapp dir
default["webapp"]["tomcat_dir"] = "#{default.common.home_dir}/tomcat/webapps"

