define cron::daily( $minute = 0, $hour = 0, $environment = [], $user = 'root', $mode = '0644', $command ) {
  cron::job {
    $name:
      minute      => $minute,
      hour        => $hour,
      date        => '*',
      month       => '*',
      weekday     => '*',
      user        => $user,
      environment => $environment,
      mode        => $mode,
      command     => $command;
  }
}

