define cron::job(
  $minute = '*', $hour = '*', $date = '*', $month = '*', $weekday = '*',
  $environment = [], $user = 'root', $command
) {
  file {
    "job_${title}":
      ensure  => file,
      owner   => root,
      group   => root,
      mode    => 0640,
      path    => "/etc/cron.d/${title}",
      content => template( 'cron/job.erb' );
  }
}

