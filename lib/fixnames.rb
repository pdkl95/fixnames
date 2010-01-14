class FixFileNames
  OPTIONS = [:advert_prefix, :brackets, :checksums, :dots, :expunge,
             :dots_to_spaces, :extra_characters, :replace]
  
  attr_accessor *OPTIONS

  def options=(opts)
    opts.each_pair do |k,v|
      if OPTIONS.include? k
        instance_variable_set "@#{k}", v || true
      end
    end
  end
  
  def self.fix(name, opts=nil)
    fixed = new(name)
    fixed.options = opts if opts
    fixed.to_s
  end
  
  def initialize(name)
    @name = name
  end

  def stat
    @stat ||= File.stat(@name)
  end

  def to_s
    x = @name.dup
    x.gsub! /([a-z])([A-Z])/, '\1_\2' # undo camel-case
    x = x.downcase
        
    if @expunge
      puts "ex[#{@expunge}] re[#{@replace}]"
      x.gsub! /#{@expunge}/, (@replace ? @replace : '')
    end
    
    if @advert_prefix
      x.gsub! /^\[[^\]]+\]/, ''
    end

    if @brackets
      x.gsub! /[\(\[].*?[\)\]]/, ''
    end
    
    if @checksums
      x.gsub! /\([0-9a-f]{8}\)/, ''
      x.gsub! /\[[0-9a-f]{8}\]/, ''
    end

    @dots = true if @dots_to_spaces

    if @dots
      while x.scan(/\./).size > 1
        if stat.file?
          # leave last dot in regular files
          x.gsub! /(.*)\.(.*\.)/, (@dots_to_spaces ? '\1_\2' : '\1\2')
        elsif stat.directory?
          # directories should be dot-free
          x.gsub! /\./, (@dots_to_spaces ? '_' : '')
        end
      end
    end

    x.gsub! /&/, '_and_'

    x.gsub! /\(\w\w\)/, ''
    x.gsub! /\[.*xvid.*\]/, ''
    x.gsub! /\[.*h264.*\]/, ''
    x.gsub! /\[.*divx.*\]/, ''
    x.gsub! /\[.*dual_audio.*\]/, ''
    
    x.gsub! /;/, '-'
    x.gsub! /\s/, '_'                   # whitespace separates field only!
    x.gsub! /[',\(\)&+!~\#@]/, ''       # kill fancy characters

    if @extra_characters
      x.gsub! /[\[\]\{\}]/, '' 
    end

    true while x.gsub! /(^|[^a-z])(xxx|xvid|xvi_d|h264|dvdrip)([^a-z]|$)/, '\3'
    
    x.gsub! /__/, '_' while x =~ /__/ # no dup 'whitespace'
    
    x.gsub! /^[_-]/, ''                 # leading 'whitespace'
    x.gsub! /[_-]\./, '.'               # 'whitespace' before the extention
    
    x.gsub! /_-_/, '-'
    x.gsub! /^-_/, ''
    
    x.gsub! /_$/, ''                    # trailing 'whitespace'

    x
  end
end
