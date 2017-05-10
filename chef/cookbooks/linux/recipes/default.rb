# Cookbook Name:: linux
# Recipe:: default
#
# Copyright IBM Corp. 2016, 2017
#
#
# <> Executes the linux-utils role.
#
include_recipe 'linux::hostsfile'
Chef::Log.info("xxxxxx - #{node['platform_family']}")
case node['platform_family']
when 'rhel'
  if node['linux']['configure']['yum_repositories'] == 'true'
    include_recipe 'linux::yumrepo'
  end
end
include_recipe 'linux::aws_setup'
