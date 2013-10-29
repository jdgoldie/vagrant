#
# Default attributes for jdk recipe.
#

include_attribute "common"

# DL URL for Oracle's servers
default["jdk"]["http_path"] = "http://download.oracle.com/otn-pub/java/jdk/7/"

# Filename of tarball retrieved from Oracle's severs
default["jdk"]["filename"] = "jdk-7-linux-i586.tar.gz"

# Full URL
default["jdk"]["url"] = "#{default.jdk.http_path}/#{default.jdk.filename}"

# Install target for Ubuntu
default["jdk"]["install_dir"] = "/usr/lib/jvm"

# The name of the top-level dir in the tarball
default["jdk"]["name"] = "jdk1.7.0"

