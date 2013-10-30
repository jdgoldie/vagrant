### Tomcat Cluster

**The following VMs are created**

|       Server Name      |    Server Role   |       IP      |  Webapps Directory  |
|:----------------------:|:----------------:|:-------------:|:-------------------:|
|   cas.altiforce.com    |    cas server    | 192.168.10.10 |     webapps_cas     |
|   www1.altiforce.com   |   tomcat server  | 192.168.10.11 |     webapps_www1    |
|   www2.altiforce.com   |   tomcat server  | 192.168.10.12 |     webapps_www2    |

*Note: the domain is not currently configurable*


#### Vagrantfile Configuration

The VMs are defined in a hash named `host_definitions` in the Vagrantfile.  It looks like this:

    host_definitions = {
      :cas => {
        :webapps_dir => "webapps_cas",
        :ip => "192.168.10.10",
        :recipes => "common,java,tomcat,webapps,hosts,cas",
        :startup => "tomcat"
      },
       :www1 => {
         :webapps_dir => "webapps_www1",
         :ip => "192.168.10.11",
         :recipes => "common,java,tomcat,webapps,hosts",
         :startup => "tomcat"
      },
       :www2 => {
         :webapps_dir => "webapps_www2",
         :ip => "192.168.10.12",
         :recipes => "common,java,tomcat,webapps,hosts",
         :startup => "tomcat"
      },   
    }


VMs can be added or removed by following the pattern of the existing definitions.  For example, adding:

       :www3 => {
         :webapps_dir => "webapps_www3",
         :ip => "192.168.10.13",
         :recipes => "common,java,tomcat,webapps,hosts",
         :startup => "tomcat"
      }   

Would add a third tomcat server to the mix.

###TODO

* leverage chef roles for config
