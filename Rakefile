# encoding: utf-8
# -*- mode: ruby -*-

require 'rubygems'
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
  gem.add_runtime_dependency "term-ansicolor", "~> 1.0.6"
  gem.add_development_dependency "rspec", "~> 2.3.0"
  gem.add_development_dependency "jeweler", "~> 1.6.4"
  gem.add_development_dependency "rcov", ">= 0"
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :default => :spec

#require 'rake/rdoctask'
#Rake::RDocTask.new do |rdoc|
#  version = File.exist?('VERSION') ? File.read('VERSION') : ""

#  rdoc.rdoc_dir = 'rdoc'
#  rdoc.title = "fixnames #{version}"
#  rdoc.rdoc_files.include('README*')
#  rdoc.rdoc_files.include('lib/**/*.rb')
#end
