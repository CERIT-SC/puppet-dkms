class dkms::install (
  $packages,
  $packages_devel,
  $apt_release
) {
  if ($::osfamily == 'Debian') and $apt_release {
    $_opts = {'-t' => $apt_release}
  } else {
    $_opts = {}
  }

  ensure_packages($packages_devel)

  ensure_packages($packages, {
    'install_options' => $_opts,
    'require'         => Package[$packages_devel],
  })
}
