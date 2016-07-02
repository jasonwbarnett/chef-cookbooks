#
# Cookbook Name:: bw_init_sample
# Recipe:: default
#
# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2
#

# this should be first.
include_recipe 'bw_init_sample::site_settings'

# HERE: yum
if node.debian? || node.ubuntu?
  include_recipe 'bw_apt'
end
# HERE: chef_client
if node.systemd?
  include_recipe 'bw_systemd'
end
include_recipe 'bw_nsswitch'
# HERE: ssh
include_recipe 'bw_modprobe'
include_recipe 'bw_securetty'
include_recipe 'bw_hosts'
include_recipe 'bw_ethers'
# HERE: resolv
include_recipe 'bw_limits'
include_recipe 'bw_hostconf'
include_recipe 'bw_sysctl'
# HERE: networking
include_recipe 'bw_syslog'
# HERE: postfix
# HERE: nfs
include_recipe 'bw_swap'
# WARNING!
# bw_fstab is one of the most powerful cookbooks in the facebook suite,
# but it requires some setup since it will take full ownership of /etc/fstab
include_recipe 'bw_fstab'
include_recipe 'bw_logrotate'
# HERE: autofs
# HERE: tmpclean
# HERE: sudo
# HERE: ntp
include_recipe 'bw_motd'

# we recommend you put this as late in the list as possible - it's one of the
# few places where APIs need to use another API directly... other cookbooks
# often want to setup cronjobs at runtime based on user attributes... they can
# do that in a ruby_block or provider if this is at the end of the 'base
# runlist'
include_recipe 'bw_cron'
