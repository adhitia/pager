#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'rake/testtask'
Rake::TestTask.new do |t|
  t.libs << 'lib/pager'
  t.libs << 'test'
  t.test_files = FileList['test/lib/pager/*_test.rb']
  t.verbose = true
end
task :default => :test
