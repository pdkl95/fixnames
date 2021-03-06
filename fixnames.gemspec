# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "fixnames"
  s.version = "0.5.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Brent Sanders"]
  s.date = "2013-02-25"
  s.description = "Cleans up filenames so they can easily be used\nin scripts, without annoyances such as spaces or other bad characters"
  s.email = "git@thoughtnoise.net"
  s.executables = ["fixnames", "fixdirs"]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".document",
    ".rspec",
    "COPYING",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "bin/fixdirs",
    "bin/fixnames",
    "fixnames.gemspec",
    "lib/fixnames.rb",
    "lib/fixnames/debug.rb",
    "lib/fixnames/engine.rb",
    "lib/fixnames/engine/scan_dir.rb",
    "lib/fixnames/filters.rb",
    "lib/fixnames/helpers.rb",
    "lib/fixnames/interface.rb",
    "lib/fixnames/option.rb",
    "lib/fixnames/version.rb",
    "spec/fixnames/and_to_dash_spec.rb",
    "spec/fixnames/badopt_spec.rb",
    "spec/fixnames/banners_spec.rb",
    "spec/fixnames/brackets_spec.rb",
    "spec/fixnames/camelcase_spec.rb",
    "spec/fixnames/charstrip_spec.rb",
    "spec/fixnames/checksums_spec.rb",
    "spec/fixnames/dashes_spec.rb",
    "spec/fixnames/expunge_spec.rb",
    "spec/fixnames/fixdots_spec.rb",
    "spec/fixnames/hack_and_spec.rb",
    "spec/fixnames/lowercase_spec.rb",
    "spec/fixnames/numsep_spec.rb",
    "spec/fixnames/semicolon_spec.rb",
    "spec/fixnames/whitespace_spec.rb",
    "spec/spec_helper.rb",
    "spec/support/option_setting_helpers.rb",
    "spec/support/should_fix_helpers.rb",
    "test/helper.rb",
    "test/test_charstrip.rb",
    "test/test_hack_and.rb",
    "test/test_lowercase.rb",
    "test/test_semicolon.rb",
    "test/test_whitespace.rb"
  ]
  s.homepage = "http://github.com/pdkl95/fixnames"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.23"
  s.summary = "Filename cleanup for script compatability"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<term-ansicolor>, [">= 1.0.6"])
      s.add_development_dependency(%q<yard>, [">= 0.6.0"])
      s.add_development_dependency(%q<rspec>, [">= 2.3.0"])
      s.add_development_dependency(%q<jeweler>, [">= 1.6.4"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
    else
      s.add_dependency(%q<term-ansicolor>, [">= 1.0.6"])
      s.add_dependency(%q<yard>, [">= 0.6.0"])
      s.add_dependency(%q<rspec>, [">= 2.3.0"])
      s.add_dependency(%q<jeweler>, [">= 1.6.4"])
      s.add_dependency(%q<simplecov>, [">= 0"])
    end
  else
    s.add_dependency(%q<term-ansicolor>, [">= 1.0.6"])
    s.add_dependency(%q<yard>, [">= 0.6.0"])
    s.add_dependency(%q<rspec>, [">= 2.3.0"])
    s.add_dependency(%q<jeweler>, [">= 1.6.4"])
    s.add_dependency(%q<simplecov>, [">= 0"])
  end
end

