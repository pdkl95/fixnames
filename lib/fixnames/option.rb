require 'abbrev'

module Fixnames
  class Option
    # the maximum number of times we will allow a filter
    # to be applied before giving up and moving on to the next
    MAX_FILTER_LOOPS = 6

    # filters that MUST run early
    SETUP_FILTERS = [
      :expunge,
      :brackets
    ]

    # filters that only accept a simple boolean on/off
    FLAG_FILTERS = [
      :hack_and,
      :and_to_dash,
      :checksums,
      :banners,
      :semicolon,
      :camelcase,
      :lowercase,
      :fix_dots,
      :fix_dashes,
      :fix_numsep
    ]

    # filters that accept character ranges
    CHAR_FILTERS = [
      :junkwords,
      :charstrip,
      :whitespace
    ]

    # filters that MUST run after everything else
    LATE_FILTERS = [
      :fix_numsep
    ]

    # standard order to apply the filters
    DEFAULT_FILTER_ORDER = [
      SETUP_FILTERS,
      FLAG_FILTERS,
      CHAR_FILTERS,
      LATE_FILTERS
    ].flatten

    DEFAULT_DIR_GLOB   = '*'
    DEFAULT_MENDSTR    = ''
    DEFAULT_WHITESPACE = " \t_"
    DEFAULT_BRACKET_CHARACTERS_OPEN  = '[({<'
    DEFAULT_BRACKET_CHARACTERS_CLOSE = '])}>'
    DEFAULT_CHARSTRIP = "[]{}'\",()+!~@#/\\<>"
    DEFAULT_JUNKWORDS = [ 'x264', 'hdtv', '2hd', '720p', 'dvdrip']
    DEFAULT_BANNER_TYPES = [ 'xxx', 'dvdrip', 'dual_audio',
                             'xvid', 'h264', 'divx' ]

    # Creates an option
    #
    # @param [String] name the name of the option to create
    # @param [Array] types a list of classes that are valid
    # @param [Object] default_val the value to set initially
    def self.mkopt(name, types, default_val)
      types = [types] unless types.is_a?(Array)
      var = "@#{name}"

      define_method "valid_for_#{name}?" do |value|
        value = nil if value == false
        return true if value.nil?
        return true if value == ''
        types.map do |type|
          value.is_a?(type)
        end.reduce(false) do |t,x|
          t || x
        end
      end

      define_method name do |*args|
        unless instance_variable_defined?(var)
          instance_variable_set(var, default_val)
        end
        if args.length == 1
          unless send("valid_for_#{name}?", args[0])
            raise ArgumentError, "bad type for option"
          end
          instance_variable_set(var, args[0])
        end
        instance_variable_get(var)
      end

      define_method "#{name}=" do |value|
        unless send("valid_for_#{name}?", value)
          raise ArgumentError, "bad type for option"
        end
        instance_variable_set(var, value)
      end
    end

    # set to turn of the ANSI-color output
    # @macro [attach] mkopt
    #   default: `$3`
    #
    #   @overload $1()
    #   @overload $1(new_value)
    #   @overload $1=(new_value)
    #   @param [$2] new_value
    #   @return [$2]
    mkopt :nocolor, [TrueClass, FalseClass], false

    # Verbosity levels
    #
    # * `verbose=0` ; no output
    # * `verbose=1` ; only names that change are output
    # * `verbose=2` ; all names are output with their change-status
    # * `verbose=3` ; all *filters* are output as they run for debugging. Very noisy.
    mkopt :verbose, Integer, 0

    # @note The maximum number of times a {Fixname::Filters} will be applied before giving and proceeding with the next filter (infinite-loop protextion)
    mkopt :max_filter_loops, Integer, MAX_FILTER_LOOPS

    # When {#recursive} is set, use this pattern to glob each
    # directory for files.
    mkopt :dir_glob, String, DEFAULT_DIR_GLOB

    # Recursively descend into directories if true.
    mkopt :recursive, [TrueClass, FalseClass], false

    # A generic pattern to remove from all filenames.
    # @note Enables {Fixnames::Filters#expunge}
    mkopt :expunge, String, nil

    # After we {#expunge} a pattern, it is replaced with this string.
    mkopt :mendstr, String, DEFAULT_MENDSTR

    # @note Enables {Fixnames::Filters#hack_and}
    mkopt :hack_and,  [TrueClass, FalseClass], false

    # @note Enables {Fixnames::Filters#hack_and}
    mkopt :and_to_dash,  [TrueClass, FalseClass], false

    # @note Enables {Fixnames::Filters#checksums}
    mkopt :checksums, [TrueClass, FalseClass], false

    # @note Enables {Fixnames::Filters#banners}
    mkopt :banners,   [TrueClass, FalseClass], false

    # @note Enables {Fixnames::Filters#brackets}
    mkopt :brackets, [TrueClass, FalseClass], false

    # @note Enables {Fixnames::Filters#semicolon}
    mkopt :semicolon, [TrueClass, FalseClass], false

    # @note Enables {Fixnames::Filters#fix_dots}
    mkopt :fix_dots, [TrueClass, FalseClass], false

    # @note Enables {Fixnames::Filters#fix_dashes}
    mkopt :fix_dashes, [TrueClass, FalseClass], false

    # @note Enables {Fixnames::Filters#fix_dashes}
    mkopt :fix_numsep, [TrueClass, FalseClass], false

    # @note Enables {Fixnames::Filters#camelcase}
    mkopt :camelcase, [TrueClass, FalseClass], false

    # @note Enables {Fixnames::Filters#lowercase}
    mkopt :lowercase, [TrueClass, FalseClass], false

    # @note Enables {Fixnames::Filters#junkwords} if non-nil
    mkopt :junkwords, Array, DEFAULT_JUNKWORDS

    # @note Enables {Fixnames::Filters#charstrip} if non-nil
    mkopt :charstrip, String, DEFAULT_CHARSTRIP

    # @note Enables {Fixnames::Filters#whitespace} if non-nil
    mkopt :whitespace, String, DEFAULT_WHITESPACE

    # The list of strings to find for removal in {Fixnames::Filters#banners}
    mkopt :banner_types, Array, DEFAULT_BANNER_TYPES

    # Set to true to have {Fixnames::Filters#charstrip} ignore its
    # default behavior and allow the brackets through. This is
    # potentially ignored if you change {#charstrip}.
    mkopt :charstrip_allow_brackets, [TrueClass, FalseClass], false

    # What is considered an *open* bracket in things
    # like {#checksums} or {#brackets}
    mkopt :bracket_characters_open,  String, DEFAULT_BRACKET_CHARACTERS_OPEN

    # What is considered a *close* bracket in things
    # like {#checksums} or {#brackets}
    mkopt :bracket_characters_close, String, DEFAULT_BRACKET_CHARACTERS_CLOSE

    # The order we should apply the filter to the filename.
    # This order is significant, and can dramatically affect
    # the output.
    mkopt :filter_order, Array, DEFAULT_FILTER_ORDER

    # if set, we just pretend to work, and skip the final
    # move command, so the filesystem is never altered
    mkopt :pretend, [TrueClass, FalseClass], false


    #################################################################

    def all_flags=(val)
      Fixnames::Option::FLAG_FILTERS.each do |f|
        send(f, val)
      end
    end

    def expunge_common_prefix!
      pfx = Dir['*'].abbrev.keys.min_by{ |k| k.length }.chop
      if pfx && pfx.length > 0
        re = "^#{Regexp.escape(pfx)}"
        STDERR.puts "DWIM-WARN: No REGEX was given to -x/--expunge"
        STDERR.puts "DWIM-WARN: Will expunge the common prefix: %r{#{re}}"
        self.expunge = re
      end
    end
  end
end
