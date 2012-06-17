define cron::hourly( $minute = 0, $user = 'root', $command ) {
  cron::job {
    $name:
      minute  => $minute,
      hour    => '*',
      date    => '*',
      month   => '*',
      weekday => '*',
      user    => $user,
      command => $command;
  }
}

