# Type: cron::weekly
#
# This type creates a cron job via a file in /etc/cron.d
#
# Parameters:
#   ensure - The state to ensure this resource exists in. Can be absent, present
#     Defaults to 'present'
#   minute - The minute the cron job should fire on. Can be any valid cron minute value.
#     Defaults to '0'.
#   hour - The hour the cron job should fire on. Can be any valid cron hour value.
#     Defaults to '0'.
#   weekday - The day of the week the cron job should fire on. Can be any valid cron weekday value.
#     Defaults to '0'.
#   environment - An array of environment variable settings.
#     Defaults to an empty set ([]).
#   user - The user the cron job should be executed as.
#     Defaults to 'root'.
#   mode - The mode to set on the created job file
#     Defaults to '0640'.
#   command - The command to execute.
#     Defaults to undef.
#   comment - Optional comment to add to the crontab file
#     Defaults to undef
#
# Actions:
#
# Requires:
#
# Sample Usage:
#   cron::weekly {
#     'delete old temp files':
#       minute      => '1',
#       hour        => '4',
#       weekday     => '7',
#       environment => [ 'MAILTO="admin@example.com"' ],
#       command     => 'find /tmp -type f -ctime +7 -exec rm -f {} \;';
#   }

define cron::weekly(
  $command = undef, $minute = 0, $hour = 0, $weekday = 0, $user = 'root',
  $mode = '0640', $ensure = 'present', $environment = [], $comment = undef,
) {
  cron::job {
    $title:
      ensure      => $ensure,
      minute      => $minute,
      hour        => $hour,
      date        => '*',
      month       => '*',
      weekday     => $weekday,
      user        => $user,
      environment => $environment,
      mode        => $mode,
      command     => $command,
      comment     => $comment,
  }
}

