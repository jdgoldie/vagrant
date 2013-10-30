### Vagrant and Chef 

A collection of Vagrantfiles and Chef cookbooks to quickly spin up various configurations of VMs on private (host-only) networks.  The files in this repo are tested with Vagrant 1.3.5 and VirtualBox 4.2.10.

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

#### tomcatCluster

`tomcatCluster/Vagrantfile` creates one VM running Tomcat with CAS installed and two Tomcat servers with the basic `manager` and `host-manager` installed.

**Servers**

|       Server Name      |    Server Role   |       IP      |  Webapps Directory  |
|:----------------------:|:----------------:|:-------------:|:-------------------:|
|   cas.altiforce.com    |    cas server    | 192.168.10.10 |     webapps_cas     |
|   www1.altiforce.com   |   tomcat server  | 192.168.10.11 |     webapps_www1    |
|   www2.altiforce.com   |   tomcat server  | 192.168.10.12 |     webapps_www2    |

*Note: the domain is not currently configurable*

Simply `vagrant up` from the `tomcatCluster` directory to start the VMs.  It may take a while as the JDK, Tomcat, and CAS files are downloaded the first time.  (Subsequent invocations do not need to download the files if a copy is still available on the local disk in the `tomcatCluster/chef` directory.

Once the machines are started.  Deploy webapps to the appropriate directories: `tomcatCluster/webapps_www1` or `tomcatCluster/webapps_www2`

#### TODO

* configurable domain
* database server options
* ???

