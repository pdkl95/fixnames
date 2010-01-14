require 'color_debug_messages'

class FixFileNames
  include ColorDebugMessages
  
  DEFAULT_OPTIONS = {
    :adverts    => false,
    :brackets   => false,
    :checksums  => false,
    :fix_dots   => true,
    :whitespace => true,
    :camelcase  => true,
    :downcase   => true,
    :basic      => true,
    :verbose    => 0
  }

  DEFAULT_PATTERNS = {
    :adverts => {
      :replace_all => ['(^|[^a-z])(xxx|xvid|xvi_d|h264|dvdrip)([^a-z]|$)','\3'],
      :remove_list => ['^\[[^\]]+\]'],
      :remove_bracket_ranges => ['xvid', 'h264', 'divx', 'dual_audio']
    },
    :brackets => {
      :remove_list => ['[\(\[].*?[\)\]]']
    },
    :checksums => {
      :remove_list => ['\([0-9a-f]{8}\)', '\[[0-9a-f]{8}\]']
    },
    :whitespace => {
      :replace_all  => ['__', '_'],
      :remove_list  => ['^[_-]', '^-_', '_$'],
      :replace_list => [ ['[_-]\.', '.'],
                         [   '_-_', '-'] ]
    },
    :basic => {
      :char_to_remove => "\[\]\{\}',\(\)+!~\#@",
      :char_to_space  => " ",
      :remove_list    => ['\(\w\w\)'],
      :replace_list   => [ ['&', '_and_'],
                           [';',     '-'] ]
    }
  }

  class FileSet
    include ColorDebugMessages
    
    def initialize(opts=Hash.new)
      @option = opts
      @option[:verbose] ||= 0
      
      @changed   = 0
      @unchanged = 0
      @set       = Array.new
      
      @debug = {
        :class_only => true,
        :warn       => false,
        :info       => false,
        :debug      => false,
      }
      @debug[:warn]  = true if @option[:verbose] > 0
      @debug[:info]  = true if @option[:verbose] > 1
      @debug[:debug] = true if @option[:verbose] > 2
      debug_flags @debug
    end

    def update_counter(changed)
      if changed
        @changed += 1
      else
        @unchanged += 1
      end
    end

    def add(val)
      @set << val
      update_counter(val.changed?)
    end

    def move!
      @set.each do |x|
        x.move!
      end
    end

    def summary_line(count, prefix='')
      if count > 0
        plural = (count == 1) ? '' : 's'
        info "#{prefix}changed: #{count} name#{plural}"
      end
    end

    def show_summary!
      if @changed > 0 or @unchanged > 0
        summary_line(@changed, '  ')
        summary_line(@unchanged, 'un')
      end
    end
  end
  
  class << self
    def option
      @option ||= DEFAULT_OPTIONS
    end

    def option=(val)
      @option = option.merge(val)
    end

    def pattern
      @pattern ||= DEFAULT_PATTERNS
    end

    def pattern=(val)
      @pattern ||= pattern.merge(val)
    end
    
    def fix(name, opts=Hash.new)
      fixed = new(name, opts)
      fixed.to_s
    end

    def fix_file(name, opts=Hash.new)
      fixed = new(name, opts)
      fixed.move!
    end

    def file_set
      @file_set ||= FileSet.new(option)
    end

    def fix_files(list, opts=Hash.new)
      list.each do |x|
        file_set.add new(x, opts)
      end
      file_set.show_summary!
      file_set.move!
    end
  end

  attr_accessor :option, :pattern
  
  def initialize(name, opts=Hash.new, pattern_opts=Hash.new)
    @name    = name.to_s
    @option  = self.class.option.merge(opts)
    @pattern = self.class.pattern.merge(pattern_opts)
    @moved   = false

    option[:verbose] ||= 0
    
    @debug = {
      :class_only => true,
      :warn       => false,
      :info       => false,
      :debug      => false,
    }
    @debug[:warn]  = true if option[:verbose] > 0
    @debug[:info]  = true if option[:verbose] > 1
    @debug[:debug] = true if option[:verbose] > 2
    debug_flags @debug
  end

  def stat
    @stat ||= File.stat(@name)
  end

  def pad(str, pad_len=24, c=' ')
    len = pad_len - str.length
    (len < 0) ? '' : (c * len)
  end

  def replace(re_string, replacement)
    if replacement.length < 1
      debug "Expunge: /#{re_string}/"
    else
      debug "Replace: /#{re_string}/ #{pad re_string}-> \"#{replacement}\""
    end
  end

  def remove(re_string)
    replace(re_string, '')
  end

  def replace_all(srch, repl)
    loop while replace(srch, repl)
  end

  def each_pattern_opt(name)
    if @pat_opt[name]
      @pat_opt[name].each do |x|
        yield(x)
      end
    end
  end

  def if_pattern_opt(name)
    if @pat_opt[name]
      yield(*(@pat_opt[name]))
    end
  end

  def filter(sym_name)
    return unless option[sym_name] and pattern[sym_name]
    @pat_opt = pattern[sym_name]
    
    if_pattern_opt(:replace_all) do |srch,repl|
      replace_all(srch,repl)
    end

    if_pattern_opt(:char_to_remove) do |x|
      remove("[#{x}]")
    end

    if_pattern_opt(:char_to_space) do |x|
      replace("[#{x}]", '_')
    end

    each_pattern_opt(:remove_list) do |x|
      remove(x)
    end

    each_pattern_opt(:remove_bracket_ranges) do |x|
      remove("\[.*?#{x}.*?\]")
    end
  end

  def downcase
    @fixed = @fixed.downcase
  end

  def camelcase
    replace('([a-z])([A-Z])', '\1_\2') if option[:camelcase]
  end

  def fix_dots
    while @fixed.scan(/\./).size > 1
      if stat.file?
        # leave last dot in regular files
        replace('(.*)\.(.*\.)', '\1_\2')
      elsif stat.directory?
        # directories should be dot-free
        replace('\.', '_')
      end
    end    
  end

  def fix_string
    @fixed = @name.dup

    [:camelcase, :downcase, :fix_dots].each do |name|
      send(name) if option[name]
    end

    pattern.each_key do |name|
      filter(name)
    end
    
    info "OLD: \"#{@name}\""
    info "NEW: \"#{@fixed}\""
    
    @fixed
  end

  def to_s
    @fixed_name ||= fix_string
  end

  def changed?
    to_s != @name
  end

  def status
    changed? ? "pretend" : "no change"
  end

  def moved?
    @moved
  end

  def move!
    return if moved?
    info "move! (#{status})"
    @moved = true
  end
end


