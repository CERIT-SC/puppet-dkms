class dkms::params {
  $apt_release = ''

  case $::operatingsystem {
    redhat,centos,scientific,oraclelinux: {
      $packages = ['dkms']
      $packages_devel = ['kernel-devel']
    }

    debian,ubuntu: {
      $packages = ['dkms']
      $packages_devel = ["linux-headers-${::architecture}"]
    }

    default: {
      fail("Unsupported OS: ${::operatingsystem}")
    }
  }
}
