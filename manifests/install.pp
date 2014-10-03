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
  case $operatingsystem {
    /(RedHat|CentOS|Amazon|OracleLinux)/:
      {
        case $operatingsystemmajrelease {
          '5':     { $package_name = 'vixie-cron' }
          default: { $package_name = 'cronie' }
        }
      }
   'Gentoo':     { $package_name = 'sys-process/vixie-cron' }
   default:      { $package_name = 'cron' }
  }

  package {
    'cron':
      ensure => $package_ensure,
      name   => $package_name;
  }
}
