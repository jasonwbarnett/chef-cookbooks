bw_hddtemp Cookbook
====================
The `bw_hddtemp` cookbook installs and configures hddtemp, an hard drive
temperature monitoring utility.

Requirements
------------
This cookbook requires CentOS, Debian or Ubuntu.

Attributes
----------
* node['bw_hddtemp']['enable']
* node['bw_hddtemp']['sysconfig']

Usage
-----
To install hddtemp include `bw_hddtemp`. Settings can be customized using the
`node['bw_hddtemp']['sysconfig']` attribute, please refer to the
[attributes file](attributes/default.rb) for the defaults, which attempt to
match upstreams distro default settings. The daemon is disabled by default, to
start it set `node['bw_hddtemp']['enable']` to true.
