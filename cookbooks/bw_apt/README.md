bw_apt Cookbook
====================
The `bw_apt` cookbook installs and configures APT, the Debian package 
management tool.

Requirements
------------

Attributes
----------
* node['bw_apt']['config']
* node['bw_apt']['keys']
* node['bw_apt']['keyring']
* node['bw_apt']['keyserver']
* node['bw_apt']['mirror']
* node['bw_apt']['preserve_sources_list_d']
* node['bw_apt']['preferences']
* node['bw_apt']['repos']
* node['bw_apt']['update_delay']
* node['bw_apt']['want_backports']
* node['bw_apt']['want_non_free']
* node['bw_apt']['want_source']

Usage
-----
To install and configure APT include `bw_apt`, which will populate the
repository sources in `/etc/apt/sources.list` and update the package cache
during the run if it's older than `node['bw_apt']['update_delay']` seconds
(defaults to 86400). To force an update on every Chef run, set this attribute
to 0. The actual update is done via the `execute[apt-get update]` resource,
which other cookbooks can suscribe to or notify as well.

### Repository sources
By default the cookbook will setup the base distribution repos based on the
codename (as defined in `node['lsb']['codename']`) using a sensible default 
mirror for the package sources. The mirror can be customized with 
`node['bw_apt']['mirror']`; if set to `nil`, base repos will not be included 
at all in `/etc/apt/sources.list`. If base repos are enabled, the additional 
`backports` and `non-free` sources can be enabled with the 
`node['bw_apt']['want_backports']` and `node['bw_apt']['want_non_free']`
attributes, and source code repos can be enabled with
`node['bw_apt']['want_source']`; these all default to `false`.

Additional repository sources can be added with `node['bw_apt']['repos']`. By
default `bw_apt` will clobber existing contents in `/etc/apt/sources.list.d` to
ensure it has full control on the repository list; this can be disabled with
`node['bw_apt']['preserve_sources_list_d']`.

### Keys
Repository keys can be added to `node['bw_apt']['keys']` which is a hash in the
`keyid => key` format; if `key` is `nil` the key will be automatically fetched
from the `node['bw_apt']['keyserver']` keyserver (`keys.gnupg.net` by default).
Example:

    node.default['bw_apt']['keys']['94558F59'] = nil
    node.default['bw_apt']['keys']['F3EFDBD9'] = <<-eos
    -----BEGIN PGP PUBLIC KEY BLOCK-----
    ...
    eos

Automatic key fetching can be disabled by setting the keyserver to `nil`; this 
will produce an exception for any unspecified key. By default `bw_apt` will 
manage the keyring at `/etc/apt/trusted.gpg`; this can be customized with
`node['bw_apt']['keyring']`.

### Configuration
APT behaviour can be customized using `node['bw_apt']['config']`, which will be
used to populate `/etc/apt/apt.conf`. Note that this will take precedence over
anything in `/etc/apt/apt.conf.d`. Example:

    node.default['bw_apt']['config'].merge!({
      'Acquire::http' => {
        'Proxy' => 'http://myproxy:3412',
      },
    })

### Preferences
You can fine tune which versions of packages will be selected for installation
by tweaking APT preferences via `node['bw_apt']['preferences']`. Note that we
clobber the contents of `/etc/apt/preferences.d` to ensure this always takes
precedence. Example:

    node.default['bw_apt']['preferences'].merge!({
      'Pin dpatch package from experimental' => {
        'Package' => 'dpatch',
        'Pin' => 'release o=Debian,a=experimental',
        'Pin-Priority' => 450,
      }
    })
