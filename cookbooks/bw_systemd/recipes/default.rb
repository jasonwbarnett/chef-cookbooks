#
# Cookbook Name:: bw_systemd
# Recipe:: default
#
# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2
#
# Copyright (c) 2016-present, Facebook, Inc.
# All rights reserved.
#
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree. An additional grant
# of patent rights can be found in the PATENTS file in the same directory.
#

unless node.systemd?
  fail 'bw_systemd is only available on systemd-enabled hosts'
end

systemd_packages = ['systemd']

case node['platform_family']
when 'rhel', 'fedora'
  systemd_packages << 'systemd-libs'
  systemd_prefix = '/usr'
when 'debian'
  systemd_packages += %w{
    libpam-systemd
    libsystemd0
    libudev1
  }

  unless node.container?
    systemd_packages << 'udev'
  end

  # older versions of Debian and Ubuntu are missing some extra packages
  unless ['trusty', 'jessie'].include?(node['lsb']['codename'])
    systemd_packages += %w{
      libnss-myhostname
      libnss-mymachines
      libnss-resolve
      systemd-container
      systemd-coredump
      systemd-journal-remote
    }
  end

  systemd_prefix = ''
else
  fail 'bw_systemd is not supported on this platform.'
end

package systemd_packages do
  only_if { node['bw_systemd']['manage_systemd_packages'] }
  action :upgrade
end

bw_systemd_reload 'system instance' do
  instance 'system'
  action :nothing
end

bw_systemd_reload 'all user instances' do
  instance 'user'
  action :nothing
end

template '/etc/systemd/system.conf' do
  source 'systemd.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    :config => 'system',
    :section => 'Manager',
  )
  notifies :run, 'bw_systemd_reload[system instance]', :immediately
end

template '/etc/systemd/user.conf' do
  source 'systemd.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    :config => 'user',
    :section => 'Manager',
  )
  notifies :run, 'bw_systemd_reload[all user instances]', :immediately
end

template '/etc/systemd/coredump.conf' do
  source 'systemd.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    :config => 'coredump',
    :section => 'Coredump',
  )
end

unless node.container?
  include_recipe 'bw_systemd::udevd'
end
include_recipe 'bw_systemd::journald'
include_recipe 'bw_systemd::journal-gatewayd'
include_recipe 'bw_systemd::journal-remote'
include_recipe 'bw_systemd::journal-upload'
include_recipe 'bw_systemd::logind'
include_recipe 'bw_systemd::networkd'
include_recipe 'bw_systemd::resolved'
include_recipe 'bw_systemd::timesyncd'

execute 'process tmpfiles' do
  command "#{systemd_prefix}/bin/systemd-tmpfiles --create"
  action :nothing
end

template '/etc/tmpfiles.d/chef.conf' do
  source 'tmpfiles.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :run, 'execute[process tmpfiles]'
end

execute 'load modules' do
  command "#{systemd_prefix}/lib/systemd/systemd-modules-load"
  action :nothing
end

directory '/etc/systemd/system-preset' do
  owner 'root'
  group 'root'
  mode '0755'
end

template '/etc/systemd/system-preset/00-bw_systemd.preset' do
  source 'preset.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

link '/etc/systemd/system/default.target' do
  to lazy { node['bw_systemd']['default_target'] }
end
