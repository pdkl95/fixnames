module Fixnames
  module Filters
    def expunge(re)
      replace re, option.mendstr
    end

    def hack_and
      replace '&', '_and_'
    end

    def and_to_dash
      replace '_and_', '-'
    end

    def semicolon
      translate ';', '-'
      fixed.squeeze! '-'
    end

    def banners
      option.banner_types.each do |x|
        remove_bracket_ranges(x)
      end
    end

    def brackets
      remove wrap_brackets('.+?')
    end

    def checksums
      remove wrap_brackets('[0-9a-fA-F]{8}')
    end

    def lowercase
      translate 'A-Z', 'a-z'
    end

    def fix_dots
      last = fixed.rindex('.')
      translate '.', '_'
      replace '(.*)\.(.*\.)', '\1_\2'
      fixed[last] = '.' if last
    end

    def fix_dashes
      fixed.squeeze! '-'
      remove  '^-' while fixed =~ /^-/
      remove  '-$' while fixed =~ /-$/
    end

    def camelcase
      replace '([a-z])([A-Z])', '\1_\2'
      fixed.downcase!
    end

    def junkwords(wordlist)
      wordlist.each do |word|
        replace "[_-]#{word}[_-]", '_'
        remove  "[_-]#{word}$"
        remove     "^#{word}[_-]"
      end
    end

    def whitespace(chrlist)
      replace "[#{Regexp.escape chrlist}]", '_'
      replace '[_-]\.', '.' while fixed =~ /[_-]\./
      replace '_-',     '-' while fixed =~ /_-/
      replace '-_',     '-' while fixed =~ /-_/
      remove  '^_'          while fixed =~ /^_/
      remove  '_$'          while fixed =~ /_$/
      fixed.squeeze! '_'
    end

    def charstrip(chrlist)
      re = Regexp.escape( if option.charstrip_allow_brackets
                            remove_bracket_characters_from(chrlist)
                          else
                            chrlist
                          end )
      remove "[#{re}]"
    end
  end
end
