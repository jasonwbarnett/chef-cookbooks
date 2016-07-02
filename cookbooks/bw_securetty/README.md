bw_securetty Cookbook
====================

Requirements
------------

Attributes
----------
* node['bw_securetty']['ttys']

Usage
-----
Add any additional securetty entries to the array 'ttys':

    # Allow root login on another console
    node.default['bw_securetty']['ttys'] << 'ttyS0'
