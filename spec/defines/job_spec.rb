require 'spec_helper'

describe 'cron::job' do
  let( :title )  { 'mysql_backup' }
  let( :params ) {{
    :environment => 'MAILTO="root"',
    :command     => 'mysqldump -u root test_db >some_file',
  }}

  it do
    should contain_file( "job_#{title}" ).with(
      'ensure'  => 'file',
      'owner'   => 'root',
      'group'   => 'root',
      'mode'    => '0640',
      'path'    => "/etc/cron.d/#{title}",
    ).with_content(
      /#{params[:environment]}/
    ).with_content(
      /#{params[:command]}/
    )
  end
end

