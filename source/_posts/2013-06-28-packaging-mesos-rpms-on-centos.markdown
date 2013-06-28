---
layout: post
title: "Packaging Mesos - RPMS on CentOS"
date: 2013-06-28 18:54
comments: true
categories: bdas
---

There is a lot of noise around <a href="http://hortonworks.com/blog/week-in-review-hadoop-summit-modern-data-architecture-and-yarn/?utm_source=feedburner&utm_medium=feed&utm_campaign=Feed%3A+hortonworks%2Ffeed+(Hortonworks+on+Hadoop)">YARN</a> and Hadoop 2.0. The concise version is, YARN splits the Hadoop JopTracker function and extracts the resource management piece into a seperate framework. This opens up powerful options to run other processing frameworks, such as graphing for example, in addition to MapReduce on Hadoop.

Although this is certainly a great step forward in Hadoop's evolution, there is another resource manager that has been around for some time and is also part of the Apache Projects called <a href="http://incubator.apache.org/mesos/">Mesos</a>. Mesos is brought to you by the awesome team at UC Berkeley that created <a href="https://amplab.cs.berkeley.edu/software/">BDAS</a> - Berkeley Data Analysis Stack. As of this post, I believe Twitter is using Mesos.

As I go deep into working on BDAS, I found it cumbersome to move .tar.gz across nodes (bins) and perhaps rpms and debs are of course more elegant - especially when it comes to automation with Chef for example.

The following documents the steps I took to create an RPM for Mesos on CentOS. I am pretty sure there are better ways to do this, but I wanted to document this for myself before moving towards Jenkins/Nesus route down the road. 

On a CentOS 6.4 node using mesos version 0.12.0:

```

[root@node1 mesos-0.12.0]#ls
aclocal.m4      bin           config.log     config.sub    depcomp     hadoop      libtool    m4           Makefile.in  NOTICE              src          third_party
ar-lib          bootstrap     config.lt      configure     DISCLAIMER  include     LICENSE    Makefile     missing      protobuf-2.4.1.jar  support
autom4te.cache  config.guess  config.status  configure.ac  ec2         install-sh  ltmain.sh  Makefile.am  mpi          README              test-driver

```

Create an install directory for the bins that need to be packaged.

```
[root@node1 mesos-0.12.0]#mkdir /<working dir>/mesosinstalldir

```

Run ./configure. I had to disable curl and perftools for compilation to work on CentOS.

```
[root@node1 mesos-0.12.0]#./configure --prefix=/usr/local/mesos --without-curl --disable-perftools

```

Run make and make install to /<working dir>/mesosinstalldir


```
[root@node1 mesos-0.12.0]#make
[root@node1 mesos-0.12.0]#make install DESTDIR=/<working dir>/mesosinstalldir

``` 

rpmbuild tools part of CentOS allow the capability to build rpms from source. However, I prefer Jordan Sissel's <a href="https://github.com/jordansissel/fpm">FPM</a>. You will need Ruby (http://rvm.io for installing a Ruby version) and install fpm with "gem install fpm". To create an rpm for mesos - mesos-0.12.0-1.x86_64.rpm, run the following:

```
[root@node1 mesos-0.12.0]#fpm --verbose --workdir /<working dir>/pkg/ -s dir -t rpm -n mesos -v 0.12.0 -C /<working dir>/mesosinstalldir/ usr/

```

Now it is much easier to distribute and install mesos on multiples nodes! Check the fpm docs on how to builds other package formates such as .debs in addition to rpms.