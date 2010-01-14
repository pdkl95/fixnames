class FixFileNames
  DEFAULT_OPTIONS = {
    :adverts    => false,
    :brackets   => false,
    :checksums  => false,
    :fix_dots   => true,
    :whitespace => true,
    :camelcase  => true,
    :downcase   => true,
    :basic      => true
#    :re_expunge     => nil,
#    :re_replace     => nil
  }

  DEFAULT_PATTERNS = {
    :adverts => {
      :replace_all => ['(^|[^a-z])(xxx|xvid|xvi_d|h264|dvdrip)([^a-z]|$)', '\3']
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
      :char_to_remove => "[]{}',\(\)+!~\#@",
      :char_to_space  => "\s",
      :remove_list    => ['\(\w\w\)']
      :replace_list   => [ ['&', '_and_'],
                           [';',     '-'] ]
    }
  }
  
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
  end

  attr_accessor :option, :pattern
  
  def initialize(name, opts=Hash.new, pattern_opts=Hash.new)
    @name    = name.to_s
    @option  = self.class.option.merge(opts)
    @pattern = self.class.pattern.merge(pattern_opts)
  end

  def stat
    @stat ||= File.stat(@name)
  end

  def replace(re_string, replacement)
  end

  def remove(re_string)
    replace re_string, ''
  end

  def each_pattern(opt, name)
    if opt[name]
      opt[name].each do |x|
        yield(x)
      end
    end
  end

  def filter(sym_name)
    return unless option[sym_name]
    return unless opt = pattern[sym_name]

    if opt[:replace_all]
      srch = opt[:replace_all][0]
      repl = opt[:replace_all][1]
      srch_re = build_re(srch)
      loop while replace(srch, repl)
    end

    each_pattern(:remove_list) do |x|
      remove(x)
    end

    each_pattern(:remove_bracket_ranges) do |x|
      remove("\[.*?#{x}.*?\]")
    end
  end

  def fix_dots
    while @fixed.scan(/\./).size > 1
      if stat.file?
        # leave last dot in regular files
        replace '(.*)\.(.*\.)', '\1_\2'
      elsif stat.directory?
        # directories should be dot-free
        replace '\.', '_'
      end
    end    
  end

  def fix_string
    @fixed = @name.dup
    
    replace '([a-z])([A-Z])/', '\1_\2' if option[:camelcase]
    @fixed = @fixed.downcase           if option[:downcase]
    fix_dots                           if option[:fix_dots]

    pattern.each_key do |name|
      filter name
    end
  end

  def to_s
    fix_string
    @fixed
  end
end
