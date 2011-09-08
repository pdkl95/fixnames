# encoding: utf-8

require 'rubygems'
require 'rake'

begin
  require 'jeweler'
rescue LoadError
  raise LoadError, "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

Jeweler::Tasks.new do |gem|
  gem.name = "fixnames"
  gem.summary = %Q{filename cleanup for scripts}
  gem.description = %Q{Cleans up filenames so they can easily be used 
in scripts, without annoyances such as spaces or other bad characters }
  gem.email = "git@thoughtnoise.net"
  gem.homepage = "http://github.com/pdkl95/fixnames"
  gem.author =["Brent Sanders"]
  gem.license = "MIT"
  gem.platform = Gem::Platform::RUBY
  gem.bindir = "bin"
  gem.executables = ["fixnames"]
  gem.add_runtime_dependency "term-ansicolor", "~> 1.0.6"
  gem.add_development_dependency "jeweler", "~> 1.6.4"
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
    test.rcov_opts << '--exclude "gems/*"'
  end
rescue LoadError
  # rcov is optional; ignore it if missing
end
task :default => :test

