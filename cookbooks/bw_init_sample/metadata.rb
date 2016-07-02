# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2
name 'bw_init_sample'
maintainer 'Facebook'
maintainer_email 'noreply@facebook.com'
license 'Apache 2.0'
description 'Setup a base runlist for using Facebook cookbooks'
source_url 'https://github.com/facebook/chef-cookbooks/'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.0.1'
%w{
  bw_apt
  bw_cron
  bw_ethers
  bw_fstab
  bw_helpers
  bw_hostconf
  bw_hosts
  bw_limits
  bw_logrotate
  bw_modprobe
  bw_motd
  bw_nsswitch
  bw_swap
  bw_securetty
  bw_sysctl
  bw_syslog
  bw_systemd
}.each do |cb|
  depends cb
end
