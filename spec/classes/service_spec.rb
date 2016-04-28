require 'spec_helper'

describe 'cron::service' do
  it do
    should contain_service( 'crond' ).with( 'ensure' => 'running' )
  end
end

