require 'spec_helper'

describe 'cron' do
  context 'unclean' do
    it { should include_class( 'cron::install' ) }
  end
  context 'clean' do
    let(:params) { {:clean => true} }
    it { should include_class( 'cron::install' ) }
    it { should contain_file( '/etc/cron.d' ) } 
  end
end

