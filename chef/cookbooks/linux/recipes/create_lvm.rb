#
# Cookbook Name::linux
# Recipe:: create_lvm
#
# Copyright IBM Corp. 2016, 2017
#
# <> Create a series of physical volumes, volume groups and logical volumes

###############################################################################
# Install LVM Libraries
###############################################################################

prereqs =  node['linux']['prereqs']['lvm']
Chef::Log.info("Installing pre-requisite packages. #{prereqs}")
case node['platform_family']
when 'rhel', 'centos', 'fedora'
  prereqs.each do |p|
    package p do
      package_name p
      action :upgrade
    end
  end
end

###############################################################################
# CREATE FILE SYSTEMS
###############################################################################

node['linux']['physicalvolumes'].each do |pv_name, pv_details|
  next if pv_name.match('INDEX') && node['linux']['skip_indexes']
  size = pv_details['size']

  Chef::Log.info("Checking for #{pv_name} with a device name of
                                 #{pv_details['device']} and a size of #{size}")

  device = if pv_details['device'].to_s.empty?
             get_disk_device(pv_details['size'])
           else
             pv_details['device']
           end

  if device.to_s.empty?
    Chef::Application.fatal!("FATAL:No device found for size #{size}", 1)
  else
    ruby_block "Save_Device_Details_#{_pv_name}" do
      block do
        node.set['linux']['physicalvolumes'][_pv_name]['device'] = device
        node.save
      end
    end
  end

  vg_name = pv_details['vg_name']
  # The Physical Volume resource adds /dev so we must strip it out

  device_name = device.gsub('/dev/', '')

  Chef::Log.info("Creating Physical Device on #{device} with a size #{size}")
  ibm_cloud_utils_lvm_physical_volume device  do
    disk device_name
    action :create
  end

  Chef::Log.info("Creating Volume Group #{vg_name} on #{device}")
  ibm_cloud_utils_lvm_volume_group vg_name do
    pv_name device
    vg_name vg_name
    action :create
  end

  pv_details['logicalvolumes'].each do |lv_name, lv_details|
    next if lv_name.match('INDEX') && node['linux']['skip_indexes']

    lv_name = lv_details['lv_name']
    Chef::Log.info("Creating Logical Volume #{lv_name} on #{vg_name}")
    ibm_cloud_utils_lvm_logical_volume 'Creating logical volume' do
      vg_name vg_name
      mountpoint lv_details['mountpoint']
      lv_name lv_details['lv_name']
      filesystem lv_details['filesystem']
      lv_size lv_details['lv_size']
      options lv_details['options']
      action :create
    end
  end
end
