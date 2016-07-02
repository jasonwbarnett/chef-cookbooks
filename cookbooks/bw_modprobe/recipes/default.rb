#
# Cookbook Name:: bw_modprobe
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

# for things to notify
ohai 'reload kernel' do
  plugin 'kernel'
  action :nothing
end

directory '/etc/modprobe.d' do
  owner 'root'
  group 'root'
  mode '0755'
end

%w{
  /etc/modprobe.d/blacklist
  /etc/modprobe.d/blacklist.rpmsave
}.each do |path|
  file path do
    action :delete
  end
end

template '/etc/modprobe.d/bw_modprobe.conf' do
  source 'bw_modprobe.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

if node.systemd?
  template '/etc/modules-load.d/chef.conf' do
    source 'modules-load.conf.erb'
    owner 'root'
    group 'root'
    mode '0644'
    notifies :run, 'execute[load modules]'
  end
else
  directory '/etc/sysconfig/modules' do
    only_if { node.centos? && !node.systemd? }
    owner 'root'
    group 'root'
    mode '0755'
  end

  template '/etc/sysconfig/modules/bw.modules' do
    only_if { node.centos? && !node.systemd? }
    source 'bw.modules.erb'
    owner 'root'
    group 'root'
    mode '0755'
  end
end
