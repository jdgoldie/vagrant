#
# Generate host data so clustered machines can find eachother
#
template "/vagrant/hosts" do
	source "hosts.erb"
	owner "vagrant"
	group "vagrant"
	mode "0644"
	variables({
		:host_entries => node["all_hosts"],
		:domain => node["common"]["domain"]
		})
end

#
# Tack on all but current host to file
#
execute "modify /etc/hosts" do
	command "chmod u+rw /etc/hosts; cat /vagrant/hosts | grep -v #{node.server} >> /etc/hosts"
	action :run
end