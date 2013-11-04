### Vagrant and Chef 

A collection of Vagrantfiles and Chef cookbooks to quickly spin up various configurations of VMs on private (host-only) networks.  The files in this repo are tested with Vagrant 1.3.5 and VirtualBox 4.2.10.

#### Roles

* tomcat
    * server running Tomcat 7.0.42
* java
    * minimal server with JDK 1.7.0 installed
* cas
    * a CAS 3.5.2 server
* base
    * a server with modified hosts file and little else

#### Cookbooks

* common
    * creates wildcard self-signed SSL certificate
    * installs utility packages
* java
    * installs Oracle JDK 1.7.0
    * installs SSL certificate in `cacerts`
* tomcat
    * installs Tomcat 7.0.42
    * activates `https`
    * configures user (`tomcat/tomcat`) for management
* webapps
    * links tomcat `webapps` folder to Vagrant synchronized folder
* cas
    * installs `cas-server-webapp` 3.5.2
* hosts
    * modifies `/etc/hosts` to include configured VMs
    * supplies `hosts` file for use with host OS
* mongo
    * installs the mongodb package from the 10gen repo

#### Cluster Definition DSL

A lightweight cluster definition DSL is defined in `util/cluster`.  It allows a cluster of VMs to be defined in a single, simple, standard Vagrantfile.  See the tomcatCluster documentation for an example of how to define a cluster.

#### tomcatCluster

`tomcatCluster/Vagrantfile` creates one VM running Tomcat with CAS installed and two Tomcat servers with the basic `manager` and `host-manager` installed.

Read more [here](https://github.com/jdgoldie/vagrant/tree/master/tomcatCluster).

#### TODO

* database server options
* zookeeper
* ???

