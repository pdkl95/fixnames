#!/bin/env ruby

# $LOAD_PATH << './lib'
require 'lib/fixnames'

FixFileNames.option = {
  :adverts   => true,
  :brackets  => true,
  :checksums => true,
  :verbose   => 2
}

FixFileNames.fix_files(ARGV)
