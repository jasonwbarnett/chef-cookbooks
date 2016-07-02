bw_motd Cookbook
====================
This cookbook generates the Message of the Day file (/etc/motd)

Requirements
------------

Attributes
----------
* node['bw_motd']['extra_lines']

Usage
-----
To add anything to the /etc/motd file, simply add lines to this array:

    node['bw_motd']['extra_lines']
