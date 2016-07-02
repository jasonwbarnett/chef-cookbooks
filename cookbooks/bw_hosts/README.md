bw_hosts Cookbook
====================
This cookbook configures /etc/hosts and provides an API for modifying all
aspects of the /etc/hosts file

Requirements
------------

Attributes
----------
* node['bw_hosts']['primary_ipaddress']
* node['bw_hosts']['primary_ip6address']
* node['bw_hosts']['host_aliases']
* node['bw_hosts']['extra_entries']

Usage
-----
## Host aliases
bw_hosts will always include the value of `node['fqdn']` as a hostname, and you
can add additional aliases via `host_aliases`:

    node.default['bw_hosts']['host_aliases'] << 'new_host_alias_entry'

We use `primary_address` and `primary_ip6address` as the addresses to set as
yourself. If you do not set these, it will use `node['ipaddress']` and
`node['ip6address']` respectively.

## Other host entries
You can add new entries into the hosts like this:

    node.default['bw_hosts']['extra_entries']['10.1.1.1'] = [
      'somehostname.mydomain.com',
    ]
