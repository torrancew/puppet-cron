require 'spec_helper'

describe 'cron' do
  it { should contain_class( 'cron::install' ) }
end

