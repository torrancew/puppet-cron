require 'spec_helper'

describe 'cron' do
  it {
    should contain_class( 'cron::install' ).with({
      'before' => ['Class[Cron::Service]'],
    })
    should contain_class( 'cron::service' )
  }
end

