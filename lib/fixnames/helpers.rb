module Fixnames
  module Helpers
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

    def match_bracket_open
      "[#{Regexp.escape(option.bracket_characters_open)}]"
    end

    def match_bracket_close
      "[#{Regexp.escape(option.bracket_characters_close)}]"
    end

    def wrap_brackets(re)
      "#{match_bracket_open}#{re}#{match_bracket_close}"
    end

    def remove_bracket_ranges(re)
      remove wrap_brackets(".*?#{re}.*?")
    end

    def remove_bracket_characters_from(str)
      str.gsub /(#{match_bracket_open}|#{match_bracket_close})/, ''
    end
  end
end
