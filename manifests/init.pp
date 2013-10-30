# Class: cron
#
# This class wraps *cron::instalL* for ease of use
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#   include 'cron'
#   class { 'cron': }

class cron {
  include cron::install

  $jobs = hiera_hash('cron::job', undef)
  if $jobs != undef {
    create_resources('cron::job', $jobs)
  }

  $daily = hiera_hash('cron::daily', undef)
  if $daily != undef {
    create_resources('cron::daily', $daily)
  }

  $weekly = hiera_hash('cron::weekly', undef)
  if $weekly != undef {
    create_resources('cron::weekly', $weekly)
  }

  $monthly = hiera_hash('cron::monthly', undef)
  if $monthly != undef {
    create_resources('cron::monthly', $monthly)
  }

  $hourly = hiera_hash('cron::hourly', undef)
  if $hourly != undef {
    create_resources('cron::hourly', $hourly)
  }
}

