Linux Cookbook
==============


# Description

The linux cookbook contains features to support the installation and management
of linux virtual machines.



## Operating System Versions Supported

* Redhat Enterprise Linux 7.x
* Redhat Enterprise Linux 6.x

## Use Cases

* Inject host entries into the linux hostfile, based on the nodes deployed.
* Add customer redhat repositories into a deployed image.
* Enable additonal redhat repositories on Amazon AMI's to allow successful deployment of Automation Conent

## Platform Pre-Requisites

* None

## Software Repository

* None

## Customer Repository Example (role contents)
The following is a sample for adding a cusomter repository.

```yaml
"linux": {
  "configure":{
    "yum_repositories": "true"
  },
  "yum_repositories": {
    "repo01": { "description": "Repository Description",
                  "repositoryid": "Name of the Repository",
                  "baseurl": "http://x.x.x.x./redhat/6/",
                  "enabled": true,
                  "gpgkey": "",
                  "gpgcheck": true,
                  "sslverify": true,
                  "sslcacert": ""
                }
  }
}

```


Requirements
------------

### Platform:

* Redhat

### Cookbooks:

*No dependencies defined*

Attributes
----------

<table>
  <tr>
    <td>Attribute</td>
    <td>Description</td>
    <td>Default</td>
  </tr>
  <tr>
    <td><code>node['linux']['configure']['yum_repositories']</code></td>
    <td>Boolen Flag to configure YUM Repositories</td>
    <td><code>false</code></td>
  </tr>
  <tr>
    <td><code>node['linux']['yum_repositories']['repo01']['baseurl']</code></td>
    <td>URL For accessing YUM Repository</td>
    <td><code>https://xx</code></td>
  </tr>
  <tr>
    <td><code>node['linux']['yum_repositories']['repo01']['description']</code></td>
    <td>Description of the YUM respository</td>
    <td><code>Yum Repository 1</code></td>
  </tr>
  <tr>
    <td><code>node['linux']['yum_repositories']['repo01']['enabled']</code></td>
    <td>Enable True/False Flag</td>
    <td><code>true</code></td>
  </tr>
  <tr>
    <td><code>node['linux']['yum_repositories']['repo01']['gpgcheck']</code></td>
    <td>GPGCheck True/False Flag</td>
    <td><code>true</code></td>
  </tr>
  <tr>
    <td><code>node['linux']['yum_repositories']['repo01']['gpgkey']</code></td>
    <td>Location of GPG Key</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['linux']['yum_repositories']['repo01']['repositoryid']</code></td>
    <td>Repository ID Name</td>
    <td><code>CAM Repository</code></td>
  </tr>
  <tr>
    <td><code>node['linux']['yum_repositories']['repo01']['sslcacert']</code></td>
    <td>Location of  sslcacert </td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['linux']['yum_repositories']['repo01']['sslverify']</code></td>
    <td>sslverify True/False Flag</td>
    <td><code>true</code></td>
  </tr>
</table>

Recipes
-------

### linux::aws_setup.rb


AWS Setup Cookbook, enable the extra repositories needed to install IBM Products.


### linux::cleanup.rb


Left Empty on purpose, not used in cookbook.


### linux::default.rb


Executes the linux-utils role.


### linux::gather_evidence.rb


Left Empty on purpose, not used in cookbook.


### linux::hostsfile.rb


Add all hosts from the all hosts in a stack to the hosts file.
Will not add the current node to the hosts file.


### linux::install.rb


Left Empty on purpose, not used in cookbook.


### linux::prereq.rb


Install prequisite packages on Linux distro


### linux::test_kitchen_fix.rb


Install net-tools for inspec testing of port numbers.


### linux::yumrepo.rb


Create xxx.repo files on a redhat server



License and Author
------------------

Author:: IBM Corp (<>)

Copyright:: 2017, IBM Corp

License:: Copyright IBM Corp. 2012, 2017

