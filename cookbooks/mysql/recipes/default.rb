#
# Install mysql server
#

# Apt-get update to refresh list
execute "apt-get update" do
	action :run
end

# Install mongo
apt_package "mysql-server" do 
	action :install
end
