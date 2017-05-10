name             'linux'
maintainer       'IBM Corp'
maintainer_email ''
license 'Copyright IBM Corp. 2012, 2017'
description <<-EOH

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
EOH
version '0.1.17'
supports 'redhat'

attribute 'linux/configure/yum_repositories',
          :default => 'false',
          :description => 'Boolen Flag to configure YUM Repositories',
          :displayname => 'Configure YUM Repositories',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :selectable => 'false',
          :type => 'string'
attribute 'linux/yum_repositories/repo01/baseurl',
          :default => 'https://xx',
          :description => 'URL For accessing YUM Repository',
          :displayname => 'Base YUM URL',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :selectable => 'false',
          :type => 'string'
attribute 'linux/yum_repositories/repo01/description',
          :default => 'Yum Repository 1',
          :description => 'Description of the YUM respository',
          :displayname => 'Description',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :selectable => 'false',
          :type => 'string'
attribute 'linux/yum_repositories/repo01/enabled',
          :default => 'true',
          :description => 'Enable True/False Flag',
          :displayname => 'Enable YUM Repo',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :selectable => 'false',
          :type => 'boolean'
attribute 'linux/yum_repositories/repo01/gpgcheck',
          :default => 'true',
          :description => 'GPGCheck True/False Flag',
          :displayname => 'Enable GPGCheck Repo',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :selectable => 'false',
          :type => 'boolean'
attribute 'linux/yum_repositories/repo01/gpgkey',
          :default => '',
          :description => 'Location of GPG Key',
          :displayname => 'GPG Key for Repository',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :selectable => 'false',
          :type => 'string'
attribute 'linux/yum_repositories/repo01/repositoryid',
          :default => 'CAM Repository',
          :description => 'Repository ID Name',
          :displayname => 'Respository ID',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :selectable => 'false',
          :type => 'string'
attribute 'linux/yum_repositories/repo01/sslcacert',
          :description => 'Location of  sslcacert ',
          :displayname => 'Location of  sslcacert '
attribute 'linux/yum_repositories/repo01/sslverify',
          :default => 'true',
          :description => 'sslverify True/False Flag',
          :displayname => 'Enable sslverify Repo',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :selectable => 'false',
          :type => 'boolean'
recipe 'linux::aws_setup.rb', '
AWS Setup Cookbook, enable the extra repositories needed to install IBM Products.
'
recipe 'linux::cleanup.rb', '
Left Empty on purpose, not used in cookbook.
'
recipe 'linux::default.rb', '
Executes the linux-utils role.
'
recipe 'linux::gather_evidence.rb', '
Left Empty on purpose, not used in cookbook.
'
recipe 'linux::hostsfile.rb', '
Add all hosts from the all hosts in a stack to the hosts file.
Will not add the current node to the hosts file.
'
recipe 'linux::install.rb', '
Left Empty on purpose, not used in cookbook.
'
recipe 'linux::prereq.rb', '
Install prequisite packages on Linux distro
'
recipe 'linux::test_kitchen_fix.rb', '
Install net-tools for inspec testing of port numbers.
'
recipe 'linux::yumrepo.rb', '
Create xxx.repo files on a redhat server
'
