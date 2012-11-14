class cron::install {
  $package_name = $operatingsystem ? {
    /(RedHat|CentOS)/ => 'cronie',
    default           => 'cron',
  }

  package { $package_name: ensure => present }
}
