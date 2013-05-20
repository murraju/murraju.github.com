# Author: Murali Raju <murali.raju@appliv.com>
#
# Copyright 2013, Murali Raju <murali.raju@appliv.com>
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# cookbooksributed under the License is cookbooksributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# -*- mode: ruby -*-
# vi: set ft=ruby :


$hdp_host_script = <<SCRIPT
#!/bin/bash
cat > /etc/hosts <<EOF
127.0.0.1       localhost

# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters

172.16.10.200   hadoop-hdp-node1
172.16.10.201   hadoop-hdp-node2
172.16.10.202   hadoop-hdp-node3
172.16.10.203   hadoop-hdp-node4
172.16.10.204   hadoop-hdp-node5
EOF

SCRIPT

Vagrant.configure("2") do |config|

  config.vm.define :hdpnamenode do |hdpnamenode|
    hdpnamenode.vm.box = "centos6.3minimal_chef11.4.0.box"
    hdpnamenode.vm.provider "vmware_fusion" do |v|
      v.vmx["memsize"]  = "2048"
    end
    hdpnamenode.vm.provider :vmware_fusion do |v|
      v.name = "hadoop-hdp-node1"
      v.customize ["modifyvm", :id, "--memory", "2048"]
    end
    hdpnamenode.vm.network :private_network, ip: "172.16.10.200"
    hdpnamenode.vm.hostname = "hadoop-hdp-node1"
    hdpnamenode.vm.synced_folder "<path>/velankanisys-chef-pantry/cookbooks", "/cookbooks"
    hdpnamenode.vm.synced_folder "<development folder path>/Development/", "/home/vagrant/dev"
    hdpnamenode.vm.provision :shell, :inline => $hdp_host_script
    hdpnamenode.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = ["<path>/velankanisys-chef-pantry/cookbooks"]
      chef.add_recipe("hadoop-hdp::default")
      chef.add_recipe("hadoop-hdp::namenode")
      chef.add_recipe("hadoop-hdp::datanode")
      chef.add_recipe("hadoop-hdp::tasktracker")
    end
  end
  
  config.vm.define :hdpjobtracker do |hdpjobtracker|
    hdpjobtracker.vm.box = "centos6.3minimal_chef11.4.0.box"
    hdpjobtracker.vm.provider "vmware_fusion" do |v|
      v.vmx["memsize"]  = "2048"
    end
    hdpjobtracker.vm.provider :vmware_fusion do |v|
      v.name = "hadoop-hdp-node2"
      v.customize ["modifyvm", :id, "--memory", "2048"]
    end
    hdpjobtracker.vm.network :private_network, ip: "172.16.10.201"
    hdpjobtracker.vm.hostname = "hadoop-hdp-node2"
    hdpjobtracker.vm.synced_folder "<path>/velankanisys-chef-pantry/cookbooks", "/cookbooks"
    hdpjobtracker.vm.synced_folder "<development folder path>/Development/", "/home/vagrant/dev"
    hdpjobtracker.vm.provision :shell, :inline => $hdp_host_script
    hdpjobtracker.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = ["<path>/velankanisys-chef-pantry/cookbooks"]
      chef.add_recipe("hadoop-hdp::default")
      chef.add_recipe("hadoop-hdp::jobtracker")
      chef.add_recipe("hadoop-hdp::datanode")
      chef.add_recipe("hadoop-hdp::tasktracker")
    end
  end
  
  config.vm.define :hdpworker1 do |hdpworker1|
    hdpworker1.vm.box = "centos6.3minimal_chef11.4.0.box"
    hdpworker1.vm.provider "vmware_fusion" do |v|
      v.vmx["memsize"]  = "1024"
    end
    hdpworker1.vm.provider :vmware_fusion do |v|
      v.name = "hadoop-hdp-node3"
      v.customize ["modifyvm", :id, "--memory", "1024"]
    end
    hdpworker1.vm.network :private_network, ip: "172.16.10.202"
    hdpworker1.vm.hostname = "hadoop-hdp-node3"
    hdpworker1.vm.synced_folder "<path>/velankanisys-chef-pantry/cookbooks", "/cookbooks"
    hdpworker1.vm.synced_folder "<development folder path>/Development/", "/home/vagrant/dev"
    hdpworker1.vm.provision :shell, :inline => $hdp_host_script
    hdpworker1.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = ["<path>/velankanisys-chef-pantry/cookbooks"]
      chef.add_recipe("hadoop-hdp::default")
      chef.add_recipe("hadoop-hdp::datanode")
      chef.add_recipe("hadoop-hdp::tasktracker")
    end
  end
  
  config.vm.define :hdpworker2 do |hdpworker2|
    hdpworker2.vm.box = "centos6.3minimal_chef11.4.0.box"
    hdpworker2.vm.provider "vmware_fusion" do |v|
      v.vmx["memsize"]  = "1024"
    end
    hdpworker2.vm.provider :vmware_fusion do |v|
      v.name = "hadoop-hdp-node4"
      v.customize ["modifyvm", :id, "--memory", "1024"]
    end
    hdpworker2.vm.network :private_network, ip: "172.16.10.203"
    hdpworker2.vm.hostname = "hadoop-hdp-node4"
    hdpworker2.vm.synced_folder "<path>/velankanisys-chef-pantry/cookbooks", "/cookbooks"
    hdpworker2.vm.synced_folder "<development folder path>/Development/", "/home/vagrant/dev"
    hdpworker2.vm.provision :shell, :inline => $hdp_host_script
    hdpworker2.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = ["<path>/velankanisys-chef-pantry/cookbooks"]
      chef.add_recipe("hadoop-hdp::default")
      chef.add_recipe("hadoop-hdp::datanode")
      chef.add_recipe("hadoop-hdp::tasktracker")
    end
  end
  
  config.vm.define :hdpworker3 do |hdpworker3|
    hdpworker3.vm.box = "centos6.3minimal_chef11.4.0.box"
    hdpworker3.vm.provider "vmware_fusion" do |v|
      v.vmx["memsize"]  = "1024"
    end
    hdpworker3.vm.provider :vmware_fusion do |v|
      v.name = "hadoop-hdp-node5"
      v.customize ["modifyvm", :id, "--memory", "1024"]
    end
    hdpworker3.vm.network :private_network, ip: "172.16.10.204"
    hdpworker3.vm.hostname = "hadoop-hdp-node5"
    hdpworker3.vm.synced_folder "<path>/velankanisys-chef-pantry/cookbooks", "/cookbooks"
    hdpworker3.vm.synced_folder "<development folder path>/Development/", "/home/vagrant/dev"
    hdpworker3.vm.provision :shell, :inline => $hdp_host_script
    hdpworker3.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = ["<path>/velankanisys-chef-pantry/cookbooks"]
      chef.add_recipe("hadoop-hdp::default")
      chef.add_recipe("hadoop-hdp::datanode")
      chef.add_recipe("hadoop-hdp::tasktracker")
    end
  end
  
end