define cron::monthly( $minute = 0, $hour = 0, $date = 1, $environment = [], $user = 'root', $mode = '0644', $command ) {
  cron::job {
    $name:
      minute      => $minute,
      hour        => $hour,
      date        => $date,
      month       => '*',
      weekday     => '*',
      user        => $user,
      environment => $environment,
      mode        => $mode,
      command     => $command;
  }
}

