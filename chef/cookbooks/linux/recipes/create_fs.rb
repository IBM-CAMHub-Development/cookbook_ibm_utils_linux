#
# Cookbook Name::linux
# Recipe:: create_fs
#
# Copyright IBM Corp. 2016, 2017
#
# <> Create 1..n disks and mount based on the ibm_cloud_fs resource


###############################################################################
# CREATE FILE SYSTEMS
###############################################################################

node['linux']['filesystems'].each do |fs_name, fs_details|

    next if fs_name.match('INDEX') && node['linux']['skip_indexes']
    size = fs_details['size']

    device = if fs_details['device'].to_s.empty?
               get_disk_device(fs_details['size'])
             else
               fs_details['device']
             end

    if device.to_s.empty?
        Chef::Application.fatal!("FATAL:No device found for size #{size}", 1)
    else
        ruby_block "Save_Device_Details_#{fs_name}" do
            block do
                node.set['linux']['filesystems'][fs_name]['device'] = device
                node.save
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
