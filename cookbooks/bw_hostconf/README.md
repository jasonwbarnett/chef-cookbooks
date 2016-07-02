bw_hostconf Cookbook
====================
This cookbook configures host.conf and provides an API for modifying all 
aspects of host.conf

Requirements
------------

Attributes
----------
* node['bw_hostconf']['trim']
* node['bw_hostconf']['multi']
* node['bw_hostconf']['nospoof']
* node['bw_hostconf']['spoofalert']
* node['bw_hostconf']['spoof']
* node['bw_hostconf']['reorder']
* node['bw_hostconf']['order']

Usage
-----
Will take arbirtrary values under `node['bw_hostconf']` and write them out
to /etc/host.conf in different ways depending on the name of key or datatype 
of the value.

If key name is 'spoof' or 'trim', the value is written out as is without 
validation

If datatype of the value is an Array the values will be written out as 
comma seperated strings

All other values are interpeted as boolean and if evaluated to true, the 
string 'on' is written out else 'off' is written out.

See man host.conf for all settable attributes

The default is

    default['bw_hostconf']['multi'] = True
