require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "fixnames"
    gem.summary = %Q{filename cleanup for scripts}
    gem.description = %Q{Cleans up filenames so they can easily be used 
in scripts, without annoyances such as spaces or other bad characters }
    gem.email = "git@thoughtnoise.net"
    gem.homepage = "http://github.com/pdkl95/fixnames"
    gem.authors = ["Brent Sanders"]
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "fixnames #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
