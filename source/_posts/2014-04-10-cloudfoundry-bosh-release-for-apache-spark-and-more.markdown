---
layout: post
title: "Cloudfoundry BOSH release for Apache Spark and more"
date: 2014-04-10 12:06
comments: true
categories: Bosh Cloudfoundry Spark Mesos
---

Time away from meetings or distractions generally leads to fishing in the Gulf, time with Family or Hacking! 

## Reason for this post

I use Apache Spark as well as Spark on Mesos extensively for my Data Science needs. In addition, other favorites include Cascalog and recently looking at Scalding. Pig and Hive still remain on my list. You can read about my tour with Apache Spark <a href="http://appliv.io/going-stealth/">here</a> and how we are using Spark at one of my companies I am building - Appliv. 

So, I wanted a way to deploy Spark or in fact any Distributed System at scale on any IaaS layer for testing or development (closely mimic production environments). In the process, allowing me quickly stand up an infrastructure to process large datasets and if needed, destroy it with a few command (clean up).

Earlier attempts made before BOSH:

1. Adhoc Ruby and Clojure scripts using Fog and JClouds (respectively) with JSON as templating. 
2. Chef with a custom Ironfan gem. Ironfan provided some hope in providing a DSL to "describe clusters" rather than nodes. However, it was still not a good fit, since it needs Chef Server (Chef is awesome on its own). It took a lot longer to ramp up on the Ironfan code base to extend it for more than one IaaS layer. Gave up eventually...
3. Discovered BOSH - rest is history.

Checkout the BOSH release for Apache Spark and more <a href="https://github.com/murraju/insightfactory-boshrelease">here</a>. This release builds on (thanks to) work done by <a href="https://github.com/frodenas">Ferran Rodenas</a> and the <a href="https://github.com/cf-platform-eng">Cloud Foundry's Platform Engineering group</a>.

To get started with BOSH, read the docs <a href="http://docs.cloudfoundry.org/">here</a>.

Things to note:

1. If you are deploying on OpenStack, make sure to disable API Throttling or find a Cloud Provider that can disable it. You can workaround API Throttling by playing with the number of instances or canary parameters, but that can be a pain.
2. The manifest files are opinionated. i.e. they were created for my own needs. Change them to fit to your needs.
3. This is work created in less than a week, so it probaly has bugs :-) Even then, I hope you find this release useful.


## Adopting Cloudfoundry

Late last year I started to execute a strategy in order to move towards an Open Platform at <a href="http://velankani.net">Velankani Information Systems</a> for <a href="http://velankani.net/how-it-works/">MDP</a>. We built everything from stratch (Java and Clojure), including the Orchestration and IaaS abstraction layers. BOSH is the first piece we hope to leverage in order to replace existing components. 

We have already started to create and test Service Brokers for a few Big Data platforms on Cloudfoundry. In addition, bring together Mesos and Cloudfoundry to deliver a comphrehensive Big Data Platform-as-Services for our Customers. There is a good <a href="http://www.cloudcredo.com/apache-mesos-paas-what-the-bosh/">post</a> by Chris Hedley at CloudCredo explaining the relationship between Mesos, BOSH and CF.

Finally, the formation of the Cloudfoundry Foundation helps us invest more on CF. Hope to share additional things in the near future.

Cheers.

Murali