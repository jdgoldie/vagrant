VAGRANTFILE_API_VERSION = "2"

module Cluster
  def self.build(name, &block)
    cluster = ClusterDefinition.new(name)
    cluster.instance_eval(&block)

    #Set default IP addresses; create a block of 50 to pull from 
    avail_ip = Array.new(50){ |index| "192.168.10.#{index + 10}" }
    cluster.host_definitions = []
    cluster.zookeeper_hosts = []

    cluster.nodes.each do |node|       
        avail_ip.delete(node.ip_addr) unless node.ip_addr.nil?
    end

    cluster.nodes.each do |node|
      node.ip_addr = avail_ip.shift if node.ip_addr.nil?
      cluster.host_definitions << "#{node.ip_addr}  #{node.name}" 
      cluster.zookeeper_hosts << "#{node.ip_addr}" if node.role_name == :zookeeper
    end

    Vagrant.configure(VAGRANTFILE_API_VERSION) do |global_config|

      cluster.nodes.each do |node|

        puts node.to_s

        global_config.vm.define node.name do |config|

          config.vm.box = "precise32"
          config.vm.box_url = "http://files.vagrantup.com/precise32.box"

          #host only network with defined ip 
          config.vm.network :private_network, ip: node.ip_addr
            
          #set memory if default overridden 
          if (node.props.key?(:memory)) then
            config.vm.provider "virtualbox" do |vm|
              vm.customize ["modifyvm", :id, "--memory", node.props[:memory].first]
            end
          end

          config.vm.provision :chef_solo do |chef|

            chef.roles_path = "../roles"
            chef.cookbooks_path = "../cookbooks"

            chef.add_role "#{node.role_name}"

            chef.json = {
                :server => node.name,
                :all_hosts => cluster.host_definitions,
                :all_hosts_names => cluster.zookeeper_hosts
            }

            #Add additional properties to map...
            chef.json[:common]={}
            chef.json[:common].merge! node.props

          end

        end

      end

    end

  end

end


class ClusterDefinition
  attr_accessor :name, :nodes, :domain, :host_definitions, :zookeeper_hosts

  def initialize(name = '')
    @name = name.to_s
    @nodes = []
  end

  def domain_name(name)
    @domain = name
  end

  def node(name, &block)
    n = Node.new(name)
    n.instance_eval(&block)
    @nodes << n
  end

  def to_s
    str = "Cluster #{@name} with base domain #{@domain} has #{@nodes.length} nodes.\n"
    @nodes.each do |n|
      str << n.to_s
    end
    str
  end
end

class Node
  attr_accessor :name, :ip_addr, :role_name, :props

  def initialize(name = '')
    @name = name.to_s
    @props = {}
  end

  def role(role)
    @role_name= role
  end

  def ip(ip) 
    @ip_addr = ip
  end

  def method_missing(m, *args, &block)  
    @props[m] = *args
  end  

  def to_s
    str = "Node #{@name} has role #{@role_name} and ip address #{@ip_addr}.\n"
    @props.each_pair do |key,value|
      str += "    #{key} => #{@props[key]}\n"
    end
    str
  end
end
