# encoding: utf-8
# -*- mode: ruby -*-

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
require './lib/fixnames/version.rb'
Jeweler::Tasks.new do |gem|
  gem.name = "fixnames"
  gem.version = Fixnames::Version::STRING
  gem.homepage = "http://github.com/pdkl95/fixnames"
  gem.license = "MIT"
  gem.summary = %Q{Filename cleanup for script compatability}
  gem.description = %Q{Cleans up filenames so they can easily be used
in scripts, without annoyances such as spaces or other bad characters}
  gem.email = "git@thoughtnoise.net"
  gem.authors = ["Brent Sanders"]
  gem.executables = ["fixnames", "fixdirs"]
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

require 'rcov/rcovtask'
Rcov::RcovTask.new do |test|
  test.libs << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
  test.rcov_opts << '--exclude "gems/*"'
end

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "fixnames #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
