# Type: cron::hourly
# 
# This type creates an hourly cron job via a file in /etc/cron.d
# 
# Parameters:
#   ensure - The state to ensure this resource exists in. Can be absent, present
#     Defaults to 'present'
#   minute - The minute the cron job should fire on. Can be any valid cron minute value.
#     Defaults to '0'.
#   environment - An array of environment variable settings.
#     Defaults to an empty set ([]).
#   mode - The mode to set on the created job file
#     Defaults to 0644.
#   user - The user the cron job should be executed as. Defaults to 'root'.
#   command - The command to execute.
#
# Actions:
#
# Requires:
#
# Sample Usage:
#   cron::hourly {
#     'generate puppetdoc':
#       minute      => '1',
#       environment => [ 'PATH="/usr/sbin:/usr/bin:/sbin:/bin"' ],
#       command     => 'puppet doc --modulepath /etc/puppet/modules >/var/www/puppet_docs.mkd';
#   }
define cron::hourly(
  $minute = 0, $environment = [], $user = 'root',
  $mode = 0644, $ensure = 'present', $command
) {
  cron::job {
    $title:
      ensure      => $ensure,
      minute      => $minute,
      hour        => '*',
      date        => '*',
      month       => '*',
      weekday     => '*',
      user        => $user,
      environment => $environment,
      mode        => $mode,
      command     => $command;
  }
}

