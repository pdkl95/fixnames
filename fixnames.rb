#!/bin/env ruby

$LOAD_PATH << 'lib'
require 'fixnames'

count_change    = 0
count_no_change = 0
ARGV.each do |old|
  puts "OLD --> \"#{old}\""
  fixed = FixFileNames.fix old, @trim
  puts "NEW ==> \"#{fixed}"
      
  if old === fixed
    count_no_change += 1
    puts "(no change)"
  else
    count_change += 1
    puts "(pretend)"
  end
end

def summary(counter, prefix='')
  plural = (counter == 1) ? '' : 's'
  puts "*** #{prefix}changed: #{counter} name#{plural}" if counter > 0
end

puts "\n" if count_change > 0 or count_no_change > 0
summary count_change
summary count_no_change, 'not '





