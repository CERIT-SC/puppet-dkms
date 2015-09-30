class dkms (
  $packages       = $dkms::params::packages,
  $packages_devel = $dkms::params::packages_devel,
  $apt_release    = $dkms::params::apt_release
) inherits dkms::params {

  validate_array($packages, $packages_devel)
  validate_string($apt_release)

  class { 'dkms::install':
    packages       => $packages,
    packages_devel => $packages_devel,
    apt_release    => $apt_release,
  }

  contain dkms::install
}
