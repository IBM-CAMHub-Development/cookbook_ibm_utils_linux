#
# Cookbook Name::linux
# Recipe:: create_fs
#
# Copyright IBM Corp. 2016, 2017
#
# <> Create 1..n disks and mount based on the ibm_cloud_fs resource

::Chef::Recipe.send(:include, LNXHelper)

###############################################################################
# CREATE FILE SYSTEMS
###############################################################################

node['linux']['filesystems'].each do |fs_name, fs_details|
  next if fs_name.match('INDEX') && node['linux']['skip_indexes']
  size = fs_details['size']

  device = fs_details['device']
  raise "Incorrect entry for device #{fs_name}: #{fs_details['device']}" unless /^\/dev\//.match(device).length == 1 && device.split('/').length == 3
  devsize = fs_details['size'].to_i * 2 * 1024**2 # size in number of 512B sectors

  # At first run we might get another device than expected
  if device.nil? || device.empty? || # no device specified
     # or specified device not present
     node['block_device'][device.split('/').last].nil? ||
     # or device exists but of different size
     node['block_device'][device.split('/').last]['size'].to_i != devsize
    device = ''
    node['block_device'].each_pair do |disk, params|
      # match on device of expected size
      next unless params['size'].to_i == devsize
      # unless it already has a filesystem
      next unless raw_volume?(disk)
      device = '/dev/' + disk
      break
    end

    # ... so update attributes with the found device, or fail if none
    if device.to_s.empty?
      Chef::Application.fatal!("No device available for filesystem #{fs_name}, size #{size}", 1)
    else
      ruby_block "Save_Device_Details_#{fs_name}" do
        block do
          node.normal['linux']['filesystems'][fs_name]['device'] = device
          node.save
        end
      end
    end
  end

  mount_dir = fs_details['mountpoint']
  Chef::Log.info("Creating mount directory #{mount_dir}")
  case node['platform_family']
  when 'rhel', 'centos', 'fedora'
    directory mount_dir do
      owner fs_details['user']
      group fs_details['group']
      mode fs_details['perms']
      action :create
      recursive true
    end
  end

  Chef::Log.info("Mounting #{mount_dir} on #{device}")
  ibm_cloud_utils_ibm_cloud_fs fs_details['label'] do
    action :enable
    device device
    mountpoint fs_details['mountpoint']
    label fs_details['label']
    fstype fs_details['fstype']
    force true
  end
end
