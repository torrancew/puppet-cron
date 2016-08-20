# Class: cron::service
#
# This class ensures that the distro-appropriate cron service is running
#
# Actions:
#
# Requires:
#
# Sample Usage:
#   This class should not be used directly under normal circumstances
#   Instead, use the *cron* class.

class cron::service {
  $service_name = $::operatingsystem ? {
    /(RedHat|CentOS|Amazon|OracleLinux)/ => 'crond',
    'Archlinux'                          => 'cronie',
    'Fedora'                             => 'crond',
    default                              => 'cron',
  }

  service {
    'crond':
      ensure => 'running',
      enable => true,
      name   => $service_name,
  }
}

