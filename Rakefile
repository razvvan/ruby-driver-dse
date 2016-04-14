# encoding: utf-8

require 'bundler/setup'

require 'rspec/core/rake_task'
require 'cucumber/rake/task'
require 'rake/testtask'
require 'bundler/gem_tasks'

ENV['FAIL_FAST'] ||= 'Y'

RSpec::Core::RakeTask.new(:rspec)

Cucumber::Rake::Task.new(:cucumber)

desc 'Run all tests'
task test: [:rspec, :integration, :cucumber]

ruby_engine = defined?(RUBY_ENGINE) ? RUBY_ENGINE : 'ruby'

case ruby_engine
when 'jruby'
  require 'rake/javaextensiontask'

  Rake::JavaExtensionTask.new('cassandra_murmur3')
else
  require 'rake/extensiontask'

  Rake::ExtensionTask.new('cassandra_murmur3')
end

Rake::TestTask.new(:integration) do |t|
  t.libs.push 'lib'
  t.test_files = FileList['integration/*_test.rb',
                          'integration/security/*_test.rb']
  t.verbose = true
end
