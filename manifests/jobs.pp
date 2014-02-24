# Type: cron::jobs
#
# This type creates multiple cron jobs via a file in /etc/cron.d
#
# Parameters:
#   ensure - The state to ensure this resource exists in. Can be absent, present
#     Defaults to 'present'
#   jobs - A hash of multiple cron jobs using the same structure as cron::job
#     Defaults to an empty hash.
#   environment - An array of environment variable settings.
#     Defaults to an empty set ([]).
#   mode - The mode to set on the created job file
#     Defaults to 0644.
#
# Actions:
#
# Requires:
#
# Sample Usage:
# $jobs     = {
#    'generate puppetdoc' => {
#      minute      => '1',
#      hour        => '*',
#      date        => '*',
#      month       => '*',
#      weekday     => '*',
#      user        => 'root',
#      command     => 'puppet doc --modulepath /etc/puppet/modules >/var/www/puppet_docs.mkd',
#    },
#    'backup mysql':
#      minute      => '1',
#      hour        => '3',
#      date        => '*',
#      month       => '*',
#      weekday     => '*',
#      environment => [ 'PATH="/usr/sbin:/usr/bin:/sbin:/bin"' ],
#      command     => 'mysqldump -u root my_db >/mnt/backups/db/daily/my_db_$(date "+%Y%m%d").sql';
#  }
#
#  cron::jobs { $name:
#    jobs        => $jobs,
#    environment => [
#      'MAILTO=root',
#      'PATH="/usr/bin:/bin"'];
#  }
define cron::jobs(
  $jobs = {},
  $environment = [], $mode = 0644, $ensure = 'present'
) {

  case $ensure {
    'present': { $real_ensure = file }
    'absent':  { $real_ensure = absent }
    default:   { fail("Invalid value '${ensure}' used for ensure") }
  }

  file {
    "job_${title}":
      ensure  => $real_ensure,
      owner   => 'root',
      group   => 'root',
      mode    => $mode,
      path    => "/etc/cron.d/${title}",
      content => template( 'cron/jobs.erb' );
  }
}
