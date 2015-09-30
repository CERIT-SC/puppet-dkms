# Puppet module for DKMS

This module installs DKMS tools and is able to manage
state of existing DKMS modules.

### Requirements

Module has been tested on:

* Puppet 3.8
* OS:
 * Debian 6,7,8
 * RHEL/CentOS 5,6,7

Required modules:

* puppetlabs-stdlib

# Quick Start

Setup

```puppet
include dkms
```

Full configuration options:

```puppet
class { 'dkms':
  packages       => [...],  # override list of packages to install
  packages_devel => [...],  # override list of devel. packages to install
  apt_release    => '...',  # force target release on apt-get based systems
}
```

DKMS module definition:

```puppet
dkms::module { 'name':
  ensure  => present|absent|installed,  # ensure state
  module  => string,                    # override module name
  kernel  => string,                    # kernel version
  version => string,                    # module version
  timeout => int,                       # build timeout
}
```

# Examples

This definition ensures the OpenAFS module ver. 1.6.9 is
built for kernel 2.6.32-573.3.1.el6.x86\_64.

```puppet
dkms::module { 'openafs':
  ensure  => installed,
  kernel  => '2.6.32-573.3.1.el6.x86_64',
  version => '1.6.9',
}
```

# Facts

### $::dkmsversion

Returns version of installed DKMS tools

```
"2.2.0.3"
```

***

CERIT Scientific Cloud, <support@cerit-sc.cz>
