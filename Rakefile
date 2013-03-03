require 'rake'
require 'rspec/core/rake_task'

task :default => :spec

RSpec::Core::RakeTask.new( :spec ) do |task|
  task.rspec_opts = %w[ --color --format doc ]
  task.pattern    = 'spec/*/*_spec.rb'
end

task :build => :spec do
  puts ''
  puts 'Building module'
  puts `puppet module build`.gsub( /^/, '  ' )
end

task :clean do
  puts 'Cleaning module builds'
  `rm -rf ./pkg/*`
end

