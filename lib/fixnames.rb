require 'term/ansicolor'

class FixFileNames
  DEFAULT_OPTIONS = {
    :hack_and   => false,
    :semicolon  => false,
    :adverts    => false,
    :brackets   => false,
    :checksums  => false,
    :fix_dots   => false,
    :camelcase  => false,
    :lowercase  => false,
    :whitespace => " \t_",
    :charstrip  => "[]{}'\",()+!~@#/\\",
    :expunge    => nil,
    :mendstr    => nil,
    :nocolor    => false,
    :verbose    => 0
  }

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

  def warn(msg);  Color.puts_msg(msg, '*', :red)    if @option[:verbose] > 0 end
  def note(msg);  Color.puts_msg(msg, '!', :yellow) if @option[:verbose] > 0 end
  def info(msg);  Color.puts_msg(msg, '-', :green)  if @option[:verbose] > 1 end
  def debug(msg); Color.puts_msg(msg, '>', :cyan)   if @option[:verbose] > 2 end

  module ClassMethods
    def option
      @option ||= DEFAULT_OPTIONS
    end

    def option=(val)
      @option = option.merge(val)
      if option[:verbose] > 2
        lines = @option.keys.map do |k|
          "\t#{k.inspect} \t=> #{@option[k].inspect},"
        end
        lines.last.chop! if lines.length > 0
        puts "FixFileNames.options = {\n#{lines.join("\n")}\n}"
      end
      @option
    end

    def fix!(name, opts=Hash.new)
      fixed = new(name, opts)
      fixed.fix!
    end

    def fix_files!(list, opts=Hash.new)
      list.map do |x|
        fix! x, opts
      end
    end
  end
  extend ClassMethods

  attr_reader :orig, :fixed, :option
  alias_method :to_s, :fixed

  def initialize(name, opts=Hash.new, pattern_opts=Hash.new)
    @option  = self.class.option.merge(opts)
    option[:verbose] ||= 0
    option[:mendstr] ||= ''

    @orig  = name.to_s.dup
    @fixed = @orig.dup

    option.keys.each do |optname|
      if option[optname] and respond_to?(optname)
        debug "FILTER[:#{optname}]"
        old = fixed.dup
        case method(optname).arity
        when 1 then send optname, option[optname]
        when 0 then send optname
        else raise "Unsupported arity in ##{optname}"
        end
        if old != fixed
          debug "\t    old -- #{old.inspect}"
          debug "\t    new -- #{fixed.inspect}"
        end
      end
    end
  end

  #module Helpers # :nodoc:all
    def stat
      @stat ||= File.stat(orig)
    end

    def pad(str, pad_len=24, c=' ')
      len = pad_len - str.length
      (len < 0) ? '' : (c * len)
    end

    def replace(re, replacement)
      re_str = bold "/#{re}/"
      replacement_str = bold "\"#{replacement}\""
      debug "\t<replace>  #{re_str}  ->  #{replacement_str}"
      fixed.gsub! Regexp.new(re), replacement
    end

    def remove(re)
      re_str = bold "/#{re}/"
      debug "\t<expunge>  #{re_str}"
      fixed.gsub! Regexp.new(re), ''
    end

    def translate(src, dst)
      debug "\t<translate>  #{bold src.inspect}  ->  #{bold dst.inspect}"
      fixed.tr! src, dst
    end

    def remove_bracket_ranges(re)
      remove "\\[.*?#{re}.*?\\]"
    end
  #end
  #include Helpers

  def hack_and
    replace '&', '_and_'
  end

  def semicolon
    translate ';', '-'
  end

  def adverts
    replace '(^|[^a-z])(xxx|xvid|xvi_d|h264|dvdrip)([^a-z]|$)', '\3'
    remove  '^\[[^\]]+\]'
    remove_bracket_ranges 'xvid'
    remove_bracket_ranges 'h264'
    remove_bracket_ranges 'divx'
    remove_bracket_ranges 'dual_audio'
  end

  def brackets
    remove '[\(\[].*?[\)\]]'
  end

  def checksums
    replace '([0-9a-f]{8})', '\[[0-9a-f]{8}\]'
  end

  def lowercase
    translate 'A-Z', 'a-z'
  end

  def fix_dots
    while fixed.scan(/\./).size > 1
      if stat.file?
        # leave last dot in regular files
        replace '(.*)\.(.*\.)', '\1_\2'
      elsif stat.directory?
        # directories should be dot-free
        replace '\.', '_'
      end
    end
  end

  def camelcase
    replace '([a-z])([A-Z])', '\1_\2'
  end

  def whitespace(chrlist)
    replace "[#{Regexp.escape chrlist}]", '_'
    replace '[_-]\.', '.' while fixed =~ /[_-]\./
    replace '_-',     '-' while fixed =~ /_-/
    replace '-_',     '-' while fixed =~ /-_/
    replace '--',     '-' while fixed =~ /--/
    remove  '^_'          while fixed =~ /^_/
    remove  '_$'          while fixed =~ /_$/
    replace '__',     '_' while fixed =~ /__/
  end

  def charstrip(chrlist)
    remove "[#{Regexp.escape chrlist}]"
  end

  def expunge(re)
    replace re, @mendstr
  end

  def changed?
    fixed != orig
  end

  def collision?
    File.exists? fixed
  end

  def fix!
    if changed?
      if collision?
        warn "NAME COLLISION: #{fixed.inspect}"
      else
        note "mv #{orig.inspect} #{fixed.inspect}"
        File.rename orig, fixed unless option[:pretend]
      end
    else
      info "no change: #{orig.inspect}"
    end
    self
  end
end


