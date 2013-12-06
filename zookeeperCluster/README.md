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

