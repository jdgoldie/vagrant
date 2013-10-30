### Tomcat Cluster

**Servers**

|       Server Name      |    Server Role   |       IP      |  Webapps Directory  |
|:----------------------:|:----------------:|:-------------:|:-------------------:|
|   cas.altiforce.com    |    cas server    | 192.168.10.10 |     webapps_cas     |
|   www1.altiforce.com   |   tomcat server  | 192.168.10.11 |     webapps_www1    |
|   www2.altiforce.com   |   tomcat server  | 192.168.10.12 |     webapps_www2    |

*Note: the domain is not currently configurable*

Simply `vagrant up` from the `tomcatCluster` directory to start the VMs.  It may take a while as the JDK, Tomcat, and CAS files are downloaded the first time.  (Subsequent invocations do not need to download the files if a copy is still available on the local disk in the `tomcatCluster/chef` directory.
	
Once the machines are started.  Deploy webapps to the appropriate directories: `tomcatCluster/webapps_www1` or `tomcatCluster/webapps_www2`.  Add the entries in `tomcatCluster/hosts` to `/etc/hosts` (or appropriate location) on your host machine OS so you can connect to the VMs by name.

Use `vagrant ssh [cas|www1|www2]` to gain shell access to the VMs.  You can `sudo` without a password.

When finished, `vagrant destroy` removes the VMs.  Downloaded files, generated SSL keys, and the `webapps_*` directories are left behind.  Unless there are significant changes to the recipes, they can be left as is.


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
