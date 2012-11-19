class cron::install {
  $package_name = $operatingsystem ? {
    /(RedHat|CentOS|OracleLinux)/ => 'cronie',
    default                       => 'cron',
  }

  package { $package_name: ensure => present }
}
