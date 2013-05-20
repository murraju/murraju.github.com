---
layout: post
title: "A 5 node Hadoop HDP 1.2 Cluster with VirtualBox, Vagrant and Chef"
date: 2013-05-19 21:29
comments: true
categories: Chef, Hadoop
---

I am happy to share the Vagrantfile I use to setup Hadoop labs when I teach various classes. The hardware used is a 16G Macbook Pro (Retina) with a 500G SSD. Should work on any Linux box with close to similar specs (not tested on Windows). Adjust the hadoop-hdp cookbook default attributes accordingly to fit to your environment. In addition, you can modify the memory requirements for each VM within the Vagrant file. Have fun!

The following are the requirements:

Velankani Information Systems, Inc Chef Cookbooks. 

```
git clone git@github.com:velankanisys/velankanisys-chef-pantry.git

```

CentOS 6.3 minimum box for VirtualBox (google for links). Preferrably repackaged with Chef 11.4.0 to remove an extra bootstrapping step.

```
rajum@~/VirtuaBox/HadoopLabHDP$ vagrant box list
aws                             (aws)
centos6.3minimal_chef11.4.0.box (virtualbox)
precise64                       (virtualbox)
ubuntu12.0.4.2.LTS.box          (virtualbox)
rajum@~/VirtuaBox/HadoopLabHDP$

```

Download and rename Vagrantfile.rb to Vagrantfile. Run "vagrant up" to launch the cluster and "vagrant status" after chef completes "cooking" to see all 5 nodes. The first run takes more time as chef runs all recipes for the first time.

```
rajum@~/VirtuaBox/HadoopLabHDP$ vagrant status
Current machine states:

hdpnamenode              running (virtualbox)
hdpjobtracker            running (virtualbox)
hdpworker1               running (virtualbox)
hdpworker2               running (virtualbox)
hdpworker3               running (virtualbox)

This environment represents multiple VMs. The VMs are all listed
above with their current state. For more information about a specific
VM, run `vagrant status NAME`.
rajum@~/VirtuaBox/HadoopLabHDP$

```


{% include_code Hadoop HDP 1.2 Vagrantfile ruby/Vagrantfile.rb %}