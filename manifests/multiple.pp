define cron::multiple
(
    $crond_path     = '/etc/cron.d',
    $environment    = [],
    $jobs,
)
{

    case $ensure{
        'present': { $real_ensure = file }
        'absent': { $real_ensure = absent }
        default: { fail("Invalid value '${ensure}' used for ensure") }
    }

    $file = "${crond_path/${name}"
    $job_defaults = { 
        'file'          => $file,
    }

    concat { "${file}" : }

    concat::fragment { "${name}_cron_header" :
        target  => $file,
        content => template('cron/fragment_header.erb'),
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
	$mode = 0644,
	$ensure = 'present',
)
{
    concat::fragment { "${name}_cron" :
        target  => $file,
        content => template('cron/fragment_job.erb'),
    }
}
