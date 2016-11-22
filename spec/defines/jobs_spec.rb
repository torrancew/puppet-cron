require 'spec_helper'

describe 'cron::jobs' do
  let(:title)  { 'mysql_backup' }
  let(:cronjob) { "job_#{title}" }
  let(:jobs) {{ 
    'daily' => {
      'minute'      => 45,
      'hour'        => 4,
      'date'        => '*',
      'month'       => '*',
      'weekday'     => '*',
      'user'        => 'backup',
      'command'     => 'mysqldump --databases test_db test_db2 > daily.sql',
    },
    'weekly' => {
      'minute'      => 45,
      'hour'        => 4,
      'date'        => '*',
      'month'       => '*',
      'weekday'     => 0,
      'user'        => 'backup',
      'command'     => 'mysqldump --all-databases > weekly.sql',
    }
  }}

  describe "job with default values" do
    let(:params) {{
      :jobs => jobs
    }}

    it do
      should contain_file(cronjob).with({
        'ensure'  => 'file',
        'owner'   => 'root',
        'group'   => 'root',
        'mode'    => '0644',
        'path'    => "/etc/cron.d/#{title}"
      })
    end

    it do 
      params[:jobs].each do |job_name, job|
        @cronline = Regexp.escape(get_cronline(job))
        should contain_file(cronjob).with_content(
            /^#\s+#{job_name}$/
          ).with_content(
            /#{@cronline}$/
          )
      end
    end
  end

  describe "job with custom values" do 
    let(:params) {{
      :mode           => '0600',
      :environment    => [ 'MAILTO="root"', 'PATH="/usr/sbin:/usr/bin:/sbin:/bin"', 'TERM="dumb"' ],
      :jobs => jobs
    }}

    it do
      should contain_file(cronjob).with({
        'owner'   => 'root',
        'mode'    => params[:mode],
      })
    end

    it do 
      should contain_file(cronjob).with_content(
        /^#{params[:environment].join('\n')}$/
      )
    end

    it do
      params[:jobs].each do |job_name, job|
        @cronline = Regexp.escape(get_cronline(job))
        should contain_file(cronjob).with_content(
             /^#\s+#{job_name}$/
          ).with_content(
            /#{@cronline}$/
          )
      end
    end
  end

  describe 'job with ensure set to absent' do
    let( :params ) {{
      :ensure  => 'absent',
      :jobs => jobs,
    }}

    it do
      should contain_file( "job_#{title}" ).with( 'ensure' => 'absent' )
    end
  end
end
