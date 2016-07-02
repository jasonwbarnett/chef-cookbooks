bw_nsswitch Cookbook
====================
This cookbook configures `/etc/nsswitch.conf` and provides an API for modifying
all aspects of the `/etc/nsswitch.conf` file.

Requirements
------------

Attributes
----------
* node['bw_nsswitch']['databases']

Usage
-----
By default we set every database to use `files` as their source, except `hosts`
which will default to `files dns`. Database mappings can be set with the
`node['bw_nsswitch']['databases']`. attribute. Example:

    node.default['bw_nsswitch']['databases']['passwd'] = [
      'files',
      'ldap',
    ]
