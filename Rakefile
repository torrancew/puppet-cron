require 'rake'
require 'json'
require 'fileutils'
require 'rspec/core/rake_task'

task :default => :spec

RSpec::Core::RakeTask.new( :spec ) do |task|
  task.rspec_opts = %w[ --color --format doc ]
  task.pattern    = 'spec/*/*_spec.rb'
end

task :build => [:spec, :clean] do
  puts ''
  `puppet module build`

  # TODO: Find a way to package without such a nasty hack
  pkg     = Dir['pkg/*.tar.gz'].first
  pkg_dir = pkg.gsub('.tar.gz', '')
  name    = pkg.match(%r{^pkg/(\w+-\w+)})[1]
  version = pkg.match(%r{\d\.\d\.\d})[0]

  # Blow away and re-create the module without specs
  # (Works around https://github.com/torrancew/puppet-cron/issues/12)
  puts `tar tvzf #{pkg}`
  FileUtils.rm_f  pkg
  Dir["#{pkg_dir}/{Rakefile,spec}"].each { |f| FileUtils.rm_rf f }

  metadata = JSON.parse(File.read("#{pkg_dir}/metadata.json"))

  metadata["checksums"].delete_if do |key, value|
    key.match(%r{^(spec/|Rakefile)})
  end

  File.open("#{pkg_dir}/metadata.json", 'w') { |f| f.write(JSON.dump(metadata)) }
  puts 'Building module'
  `tar cvzf #{pkg} -C pkg/ #{name}-#{version}/`
  puts `tar tvzf #{pkg}`
end

task :clean do
  puts 'Cleaning module builds'
  Dir['pkg/*'].each { |f| FileUtils.rm_rf f }
end

