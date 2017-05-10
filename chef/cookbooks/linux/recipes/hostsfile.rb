# Cookbook Name:: linux
# Recipe:: hostsfile
#
# Copyright IBM Corp. 2016, 2017
#
#
# <> Add all hosts from the all hosts in a stack to the hosts file.
# <> Will not add the current node to the hosts file.
#

query = "stack_id:#{node['ibm_internal']['stack_id']}"

ruby_block 'search_nodes_in_stack' do
  block do
    Chef::Log.info("Search for nodes in stack")
    Chef::Config[:solo] == true ? (nodes = []) : (nodes = search(:node, query))
    nodes.each do |n|
      n['hostname'] == n['fqdn'] ? (line = "#{n['ipaddress']} #{n['fqdn']}") : (line = "#{n['ipaddress']} #{n['fqdn']} #{n['hostname']}")
      Chef::Log.info("Adding #{line} to hosts file if not present")
      hostsfile = Chef::Util::FileEdit.new(node['linux']['hostsfile'])
      hostsfile.insert_line_if_no_match(/#{n['ipaddress']}/, line)
      hostsfile.write_file
    end
  end
end
