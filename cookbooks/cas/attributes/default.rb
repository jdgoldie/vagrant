#
# Default attributes for cas recipe.
#

include_attribute "common"

# CAS Version 
#http://downloads.jasig.org/cas/cas-server-3.5.2-release.tar.gz
default["cas"]["major_version"] = "3"
default["cas"]["minor_version"] = "5"
default["cas"]["release_version"] = "2"
default["cas"]["version"] = "#{default.cas.major_version}.#{default.cas.minor_version}.#{default.cas.release_version}"

# cas name
default["cas"]["name"] = "cas-server-#{default.cas.version}"

# Download Mirror
default["cas"]["mirror"] = "downloads.jasig.org"

# cas DL URL
default["cas"]["url"] = "http://#{default.cas.mirror}/cas/#{default.cas.name}-release.tar.gz"
