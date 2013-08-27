require 'spec_helper'

describe 'cron::job' do
  let( :title )  { 'mysql_backup' }

  describe 'job with default values' do
    let( :params ) {{ :command => 'mysqldump -u root test_db >some_file' }}
    let( :cron_timestamp ) { get_timestamp( params ) }

    it do
      should contain_file( "job_#{title}" ).with(
        'ensure'  => 'file',
        'owner'   => 'root',
        'group'   => 'root',
        'mode'    => '0644',
        'path'    => "/etc/cron.d/#{title}"
      ).with_content(
        /\n#{cron_timestamp}\s+/
      ).with_content(
        /\s+#{params[:command]}\n/
      )
    end
  end

  describe 'job with custom values' do
    let( :params ) {{
      :minute      => '45',
      :hour        => '7',
      :date        => '12',
      :month       => '7',
      :weekday     => '*',
      :environment => [ 'MAILTO="root"', 'PATH="/usr/sbin:/usr/bin:/sbin:/bin"' ],
      :user        => 'admin',
      :mode        => '0640',
      :command     => 'mysqldump -u root test_db >some_file',
    }}
    let( :cron_timestamp ) { get_timestamp( params ) }

    it do
      should contain_file( "job_#{title}" ).with(
        'owner'   => 'root',
        'mode'    => params[:mode]
      ).with_content(
        /\n#{params[:environment].join('\n')}\n/
      ).with_content(
        /\n#{cron_timestamp}\s+/
      ).with_content(
        /\s+#{params[:user]}\s+/
      ).with_content(
        /\s+#{params[:command]}\n/
      )
    end
  end

  describe 'job with ensure set to absent' do
    let( :params ) {{
      :ensure  => 'absent',
      :command => 'mysqldump -u root test_db >some_file',
    }}

    it do
      should contain_file( "job_#{title}" ).with( 'ensure' => 'absent' )
    end
  end
end

