if ($::operatingsystem != 'Debian') {
  fail('This test must be run Debian!')
} else {
  case $::operatingsystemmajrelease {
    6: { $version = '1.4.12' }
    7: { $version = '1.6.1' }
    8: { $version = '1.6.9' }
    default: { fail("Unsupported Debian rel. ${::operatingsystemmajrelease}") }
  }
}

package { 'openafs-modules-dkms':
  ensure => installed,
}

Dkms::Module {
  module  => 'openafs',
  version => $version,
}

dkms::module { 'openafs-absent':
  ensure  => absent,
  require => Package['openafs-modules-dkms'],
}

dkms::module { 'openafs-present':
  ensure  => present,
  require => Dkms::Module['openafs-absent'],
}

dkms::module { 'openafs-installed':
  ensure  => installed,
  require => Dkms::Module['openafs-present'],
}
