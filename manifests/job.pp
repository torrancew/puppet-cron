# Type: cron::job
# 
# This type creates a cron job via a file in /etc/cron.d
# 
# Parameters:
#   ensure - The state to ensure this resource exists in. Can be absent, present
#     Defaults to 'present'
#   minute - The minute the cron job should fire on. Can be any valid cron minute value.
#     Defaults to '*'.
#   hour - The hour the cron job should fire on. Can be any valid cron hour value.
#     Defaults to '*'.
#   date - The date the cron job should fire on. Can be any valid cron date value.
#     Defaults to '*'.
#   month - The month the cron job should fire on. Can be any valid cron month value.
#     Defaults to '*'.
#   weekday - The day of the week the cron job should fire on. Can be any valid cron weekday value.
#     Defaults to '*'.
#   environment - An array of environment variable settings.
#     Defaults to an empty set ([]).
#   mode - The mode to set on the created job file
#     Defaults to 0644.
#   user - The user the cron job should be executed as.
#     Defaults to 'root'.
#   command - The command to execute.
#
# Actions:
#
# Requires:
#
# Sample Usage:
#   cron::job {
#     'generate puppetdoc':
#       minute      => '01',
#       environment => [ 'PATH="/usr/sbin:/usr/bin:/sbin:/bin"' ],
#       command     => 'puppet doc --modulepath /etc/puppet/modules >/var/www/puppet_docs.mkd';
#   }
define cron::job(
  $minute = '*', $hour = '*', $date = '*', $month = '*', $weekday = '*',
  $environment = [], $user = 'root', $mode = 0644, $ensure = 'present', $command
) {

  case $ensure {
    "present": { $real_ensure = file }
    "absent":  { $real_ensure = absent }
    default:   { fail("Invalid value '${ensure}' used for ensure") }
  }

  file {
    "job_${title}":
      ensure  => $real_ensure,
      owner   => 'root',
      group   => 'root',
      mode    => $mode,
      path    => "/etc/cron.d/${title}",
      content => template( 'cron/job.erb' );
  }
}

