### Tomcat Cluster

**Servers**

|       Server Name      |    Server Role   |       IP      |
|:----------------------:|:----------------:|:-------------:|
|     zoo1.local.net     |    zookeeper     | 192.168.10.10 |
|     zoo2.local.net     |    zookeeper     | 192.168.10.11 |
|     zoo3.local.net     |    zookeeper     | 192.168.10.12 |


Simply `vagrant up` from the `zookeeperCluster` directory to start the VMs.  The JDK and zookeeper distributions are downloaded for the initial VM provisionin.  Subsequent invocations do not need to download the files if a copy is still available on the local disk in the `zookeeperCluster/chef` directory.
	
Use `vagrant ssh zoo[1-3]` to gain shell access to the VMs.  You can `sudo` without a password.

When finished, `vagrant destroy` removes the VMs. 

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
