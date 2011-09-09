# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "fixnames"
  s.version = "0.1.0.pre1"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1") if s.respond_to? :required_rubygems_version=
  s.authors = ["Brent Sanders"]
  s.date = "2011-09-09"
  s.description = "Cleans up filenames so they can easily be used\nin scripts, without annoyances such as spaces or other bad characters"
  s.email = "git@thoughtnoise.net"
  s.executables = ["fixnames", "fixdirs"]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "bin/fixdirs",
    "bin/fixnames",
    "fixnames.gemspec",
    "lib/fixnames.rb",
    "lib/fixnames/version.rb",
    "spec/fixnames/charstrip_spec.rb",
    "spec/fixnames/whitespace_spec.rb",
    "spec/spec_helper.rb",
    "spec/support/should_fix_helpers.rb",
    "spec/test_hack_and.rb",
    "spec/test_lowercase.rb",
    "spec/test_semicolon.rb"
  ]
  s.homepage = "http://github.com/pdkl95/fixnames"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "Filename cleanup for script compatability"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<term-ansicolor>, ["~> 1.0.6"])
      s.add_development_dependency(%q<rspec>, ["~> 2.3.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
    else
      s.add_dependency(%q<term-ansicolor>, ["~> 1.0.6"])
      s.add_dependency(%q<rspec>, ["~> 2.3.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_dependency(%q<rcov>, [">= 0"])
    end
  else
    s.add_dependency(%q<term-ansicolor>, ["~> 1.0.6"])
    s.add_dependency(%q<rspec>, ["~> 2.3.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
    s.add_dependency(%q<rcov>, [">= 0"])
  end
end

