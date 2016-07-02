# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2
name 'bw_fstab'
maintainer 'Facebook'
maintainer_email 'noreply@facebook.com'
license 'BSD'
description 'Installs/Configures mounts and /etc/fstab'
source_url 'https://github.com/facebook/chef-cookbooks/'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.0.1'
depends 'bw_swap'
depends 'bw_helpers'
