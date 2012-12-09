define cron::hourly( $minute = 0, $environment = [], $user = 'root', $mode = '0644', $command ) {
  cron::job {
    $name:
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

