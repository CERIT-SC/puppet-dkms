define dkms::module (
  $version,
  $ensure  = present,
  $module  = $title,
  $kernel  = $::kernelrelease,
  $timeout = 600,
) {
  require ::dkms

  Exec {
    path => '/bin:/usr/bin:/sbin:/usr/sbin',
  }

  $_common = "-m ${module} -v ${version}"
  $_kernel = $kernel ? {
    all     => '--all',
    default => "-k ${kernel}"
  }

  case $ensure {
    present,installed: {
      exec { "dkms-add-${title}-${version}":
        command => "dkms add    ${_common}",
        unless  => "dkms status ${_common} | grep ''",
      }

      if $ensure == installed {
        exec { "dkms-build-${title}-${version}":
          command => "dkms build ${_common} ${_kernel}",
          unless  => "dkms status ${_common} ${_kernel} | egrep ': (built|installed)'",
          require => Exec["dkms-add-${title}-${version}"],
          timeout => $timeout,
        }

        exec { "dkms-install-${title}-${version}":
          command => "dkms install ${_common} ${_kernel}",
          unless  => "dkms status ${_common} ${_kernel} | egrep ': installed'",
          require => Exec["dkms-build-${title}-${version}"];
        }
      }
    }

    absent: {
      exec { "dkms-remove-${title}-${version}":
        command => "dkms remove ${_common} ${_kernel}",
        onlyif  => "dkms status ${_common} ${_kernel} | grep ''",
      }
    }

    default: {
      fail("Unsupported ensure state: ${ensure}")
    }
  }
}
