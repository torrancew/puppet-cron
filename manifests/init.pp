# Class: cron
#
# This class wraps *cron::instalL* for ease of use
#
# Parameters:
#
# [*clean*]
#  Default false - if we should clean /etc/cron.d/ of any jobs we find which are unmanaged
#
# Actions:
#
# Requires:
#
# Sample Usage:
#   include 'cron'
#   class { 'cron': }

class cron ( $clean = false ) {
  include cron::install
  if str2bool($clean) {
    file { '/etc/cron.d':
      ensure  => directory,
      recurse => true,
      force   => true,
      replace => true,
      purge   => true,
    }
  }
}

