class cron::install {
  $package_name = $operatingsystem ? {
    /(RedHat|CentOS|OracleLinux)/ => 'cronie',
    default                       => 'cron',
  }

  package {
    'cron':
      ensure => installed,
      name   => $package_name;
  }
}

