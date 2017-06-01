class dkms::install {
  if ($::osfamily == 'Debian') and ! empty($::dkms::apt_release) {
    $_opts = {'-t' => $::dkms::apt_release}
  } else {
    $_opts = {}
  }

  ensure_packages($::dkms::packages_devel)

  ensure_packages($::dkms::packages, {
    'install_options' => $_opts,
    'require'         => Package[$::dkms::packages_devel],
  })
}
