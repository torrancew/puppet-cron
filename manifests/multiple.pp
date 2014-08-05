define cron::multiple
(
    $crond_path     = '/etc/cron.d',
    $environment    = [],
	$mode           = 0644,
    $jobs,
)
{

    $file = "${crond_path}/${title}"
    $job_defaults = { 
        'file'          => $file,
    }

    concat { "${file}" : 
        mode    => $mode
    }

    concat::fragment { "${title}_cron_header" :
        target  => $file,
        content => template('cron/fragment_header.erb'),
        order   => '1',
    }

    create_resources('cron::multiple::job', $jobs, $job_defaults)

}

define cron::multiple::job
(
    $file,
    $command,
	$minute = '*',
	$hour = '*',
	$date = '*',
	$month = '*',
	$weekday = '*',
	$user = 'root',
)
{
    concat::fragment { "${title}_cron" :
        target  => $file,
        content => template('cron/fragment_job.erb'),
        order   => '2',
    }
}
