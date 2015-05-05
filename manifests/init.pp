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

class cron (
  $jobs = {},
  $daily = {},
  $hourly = {},
  $monthly = {},
  $weekly = {},
)  {
  include cron::install

  create_resources('cron::job', $jobs)
  create_resources('cron::daily', $daily)
  create_resources('cron::hourly', $hourly)
  create_resources('cron::monthly', $monthly)
  create_resources('cron::weekly', $weekly) 
}

