define cron::job( $minute = '*', $hour = '*', $date = '*', $month = '*', $weekday = '*', $user = 'root', $command ) {
  file {
    "job_${name}":
      ensure  => present,
      owner   => root,
      group   => root,
      mode    => 0640,
      path    => "/etc/cron.d/${name}",
      content => template( 'cron/job.erb' );
  }
}

