# Class: cron::install
#
# This class ensures that the distro-appropriate cron package is installed
#
# Parameters:
#   package_ensure - Can be set to a package version, 'latest', 'installed' or 'present'.
#
# Actions:
#
# Requires:
#
# Sample Usage:
#   This class should not be used directly under normal circumstances
#   Instead, use the *cron* class.

class cron::install (
  $package_ensure = 'installed'
) {
  $package_name = $::operatingsystem ? {
    /(RedHat|CentOS|Amazon|OracleLinux)/ => 'cronie',
    'Gentoo'                             => 'sys-process/vixie-cron',
    'Ubuntu'                             => 'cron',
    default                              => 'cron',
  }

  package {
    'cron':
      ensure => $package_ensure,
      name   => $package_name;
  }
}

