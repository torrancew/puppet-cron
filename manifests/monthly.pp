define cron::monthly( $minute = 0, $hour = 0, $date = 1, $user = 'root', $command ) {
  cron::job {
    $name:
      minute  => $minute,
      hour    => $hour,
      date    => $date,
      month   => '*',
      weekday => '*',
      user    => $user,
      command => $command;
  }
}

