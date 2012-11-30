define cron::job(
  $minute = '*', $hour = '*', $date = '*', $month = '*', $weekday = '*',
  $environment = [], $user = 'root', $mode = '0644', $command
) {
  file {
    "job_${name}":
      ensure  => present,
      owner   => root,
      group   => root,
      mode    => $mode,
      path    => "/etc/cron.d/${name}",
      content => template( 'cron/job.erb' );
  }
}

