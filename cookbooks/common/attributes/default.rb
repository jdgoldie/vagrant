#
# Common attributes for all recipes
#

# A common shared dir among all vagrant VMs.  Ensures that remote
# files only DL once and are then shared
default["common"]["chef_cache"] = "/vagrant/chef"

# The home dir of the vagrant user
default["common"]["home_dir"] = "/home/vagrant"	

# The domain name; for SSL cert, /etc/hosts
default["common"]["domain"] = "local.net"

# The SSL key name
default["common"]["key_alias"] = "localnet"
