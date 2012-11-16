define cron::hourly( $minute = 0, $environment = [], $user = 'root', $command ) {
  cron::job {
    $title:
      minute      => $minute,
      hour        => '*',
      date        => '*',
      month       => '*',
      weekday     => '*',
      user        => $user,
      environment => $environment,
      command     => $command;
  }
}

