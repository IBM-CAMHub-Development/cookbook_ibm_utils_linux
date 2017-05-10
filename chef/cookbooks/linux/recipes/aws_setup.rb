# Cookbook Name:: linux
# Recipe:: aws_setup
#
# Copyright IBM Corp. 2017, 2017
#
# <> AWS Setup Cookbook, enable the extra repositories needed to install IBM Products.

execute 'enable-extra-repository' do
  command 'yum-config-manager --enable rhui-REGION-rhel-server-extras rhui-REGION-rhel-server-optional'
  only_if { awscloud? }
end
