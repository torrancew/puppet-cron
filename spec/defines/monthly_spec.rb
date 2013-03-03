require 'spec_helper'

describe 'cron::monthly' do
  let( :title )  { 'mysql_backup' }
  let( :params ) {{
    :minute      => '59',
    :hour        => '1',
    :date        => '20',
    :command     => 'mysqldump -u root test_db >some_file'
  }}

  it do
    should contain_cron__job( title ).with(
      'minute'      => params[:minute],
      'hour'        => params[:hour],
      'date'        => params[:date],
      'month'       => '*',
      'weekday'     => '*',
      'user'        => params[:user] || 'root',
      'environment' => params[:environment] || [],
      'mode'        => params[:mode] || '0644',
      'command'     => params[:command]
    )
  end
end

