class dkms::params {
  $apt_release = undef

  case $::operatingsystem {
    'RedHat','CentOS','Scientific','OracleLinux': {
      $packages = ['dkms']
      $packages_devel = ['kernel-devel']
    }

    'Debian','Ubuntu': {
      $packages = ['dkms']
      $packages_devel = ["linux-headers-${::architecture}"]
    }

    default: {
      fail("Unsupported OS: ${::operatingsystem}")
    }
  }
}
