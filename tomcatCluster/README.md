### Tomcat Cluster

**Servers**

|       Server Name      |    Server Role   |       IP      |  Webapps Directory  |
|:----------------------:|:----------------:|:-------------:|:-------------------:|
|     cas.local.net      |    cas server    | 192.168.10.10 |     webapps_cas     |
|     www1.local.net     |   tomcat server  | 192.168.10.11 |     webapps_www1    |
|     www2.local.net     |   tomcat server  | 192.168.10.12 |     webapps_www2    |


Simply `vagrant up` from the `tomcatCluster` directory to start the VMs.  It may take a while as the JDK, Tomcat, and CAS files are downloaded the first time.  (Subsequent invocations do not need to download the files if a copy is still available on the local disk in the `tomcatCluster/chef` directory.
	
Once the machines are started.  Deploy webapps to the appropriate directories: `tomcatCluster/webapps_www1` or `tomcatCluster/webapps_www2`.  Add the entries in `tomcatCluster/hosts` to `/etc/hosts` (or appropriate location) on your host machine OS so you can connect to the VMs by name.

Use `vagrant ssh [cas|www1|www2]` to gain shell access to the VMs.  You can `sudo` without a password.

When finished, `vagrant destroy` removes the VMs.  Downloaded files, generated SSL keys, and the `webapps_*` directories are left behind.  Unless there are significant changes to the recipes, they can be left as is.


#### Vagrantfile Configuration

The VMs are defined using a ruby DSL in the Vagrantfile.  It looks like this:

    require "../util/cluster"

    cluster = Cluster.build :tomcat_cas do

      domain_name "local.net"

      #CAS Server
      node (:cas) {
        role :cas
        webapps "webapps_cas"
        memory 496
        ip "192.168.10.10"    
      }
      #Tomcat #1
      node (:www1) {
        role :tomcat
        webapps "webapps_www1"
        memory 496    
        ip "192.168.10.11"    
      }
      #Tomcat #2
      node (:www2) {
        role :tomcat
        webapps "webapps_www2"
        memory 496    
        ip "192.168.10.12"    
      }

    end

The domain of the cluster is set using the optional `domain_name` setting.

The individual VMs are speficied in one or more `node` sections.  At minumum, each `node` needs a `role`.  The `role` should match one defined in the `roles` directory.  The `webapps`, `ip`, and `memory` settings are optional but can be specified if desired.