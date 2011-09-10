require 'term/ansicolor'

module Fixnames
  module Debug
    class Color
      extend Term::ANSIColor

      def self.prefix(chr, cname)
        #raise "#{cname.inspect}, #{send(cname).inspect}"
        [Color.send(cname), Color.bold, "#{chr}#{chr}>", Color.clear].join
      end

      def self.puts_msg(str, chr, cname)
        puts "#{prefix(chr, cname)} #{str}"
      end
    end

    def bold(str)
      [ Color.bold,
        Color.yellow,
        Color.on_blue,
        str,
        Color.clear
      ].join
    end

    def warn(msg)
      Color.puts_msg(msg, '*', :red)    if @option[:verbose] > 0
    end

    def note(msg)
      Color.puts_msg(msg, '!', :yellow) if @option[:verbose] > 0
    end

    def info(msg)
      Color.puts_msg(msg, '-', :green)  if @option[:verbose] > 1
    end

    def debug(msg)
      Color.puts_msg(msg, '>', :cyan)   if @option[:verbose] > 2
    end
  end
end
