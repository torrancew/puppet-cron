class cron::install {
  package { 'cron': ensure => present }
}
