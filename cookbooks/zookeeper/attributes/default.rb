#
# Default attributes for zookeeper recipe.
#

include_attribute "common"

# zookeeper Version
default["zookeeper"]["major_version"] = "3"
default["zookeeper"]["minor_version"] = "4"
default["zookeeper"]["release_version"] = "5"
default["zookeeper"]["version"] = "#{default.zookeeper.major_version}.#{default.zookeeper.minor_version}.#{default.zookeeper.release_version}"

# zookeeper name
default["zookeeper"]["name"] = "zookeeper-#{default.zookeeper.version}"

# Download Mirror
default["zookeeper"]["mirror"] = "apache.cs.utah.edu"

# zookeeper DL URL
default["zookeeper"]["url"] = "http://#{default.zookeeper.mirror}/zookeeper/stable/#{default.zookeeper.name}.tar.gz"
