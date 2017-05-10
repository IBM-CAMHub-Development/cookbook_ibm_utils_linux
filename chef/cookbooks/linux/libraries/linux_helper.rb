# Cookbook Name:: linux
# Library:: linux_helper
#
# Copyright IBM Corp. 2016, 2017
#

# <> library: Linux helper
# <> Library Functions for the Linux Cookbook
module LINUXHelper
  # Helper functions for Linux cookbook
  include Chef::Mixin::ShellOut

  # Functions to determine install status and version for IHS
  def awscloud?
    get_version = 'cat /sys/devices/virtual/dmi/id/bios_version'

    begin
      !/amazon$/.match(shell_out(get_version).stdout).to_s.empty?
    rescue Errno::ENOENT => e
      Chef::Log.info "File not found: #{get_version}, error: #{e}"
      return false
    end
  end
end

Chef::Recipe.send(:include, LINUXHelper)
Chef::Resource.send(:include, LINUXHelper)
