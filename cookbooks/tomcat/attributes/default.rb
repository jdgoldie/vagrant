#
# Default attributes for tomcat recipe.
#

include_attribute "common"

# Tomcat Version
default["tomcat"]["major_version"] = "7"
default["tomcat"]["minor_version"] = "0"
default["tomcat"]["release_version"] = "42"
default["tomcat"]["version"] = "#{default.tomcat.major_version}.#{default.tomcat.minor_version}.#{default.tomcat.release_version}"

# Tomcat name
default["tomcat"]["name"] = "apache-tomcat-#{default.tomcat.version}"

# Download Mirror
default["tomcat"]["mirror"] = "archive.apache.org"

# Tomcat DL URL
default["tomcat"]["url"] = "http://#{default.tomcat.mirror}/dist/tomcat/tomcat-#{default.tomcat.major_version}/v#{default.tomcat.version}/bin/#{default.tomcat.name}.tar.gz"
