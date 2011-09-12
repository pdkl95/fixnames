module Fixnames
  FLAG_FILTERS = [ :hack_and, :checksums, :banners,
                   :brackets, :semicolon,
                   :camelcase, :lowercase,
                   :fix_dots, :fix_dashes ]

  DEFAULT_OPTIONS = {
    ####################
    # filename options #
    ####################

    :expunge => nil,
    :mendstr => nil,

    :hack_and   => false,
    :checksums  => false,
    :banners    => false,

    :brackets   => false,
    :semicolon  => false,
    :fix_dots   => false,
    :fix_dashes => false,

    :camelcase  => false,
    :lowercase  => false,

    :junkwords  => [ 'x264', 'hdtv', '2hd',
                     '720p', 'dvdrip'
                   ],

    :charstrip  => "[]{}'\",()+!~@#/\\",
    :whitespace => " \t_",

    :banner_types => [ 'xxx', 'dvdrip', 'dual_audio',
                       'xvid', 'h264', 'divx'
                     ],

    :charstrip_allow_brackets => false,
    :bracket_characters_open  => '[({<',
    :bracket_characters_close => '])}>',

    :filter_order => [ :expunge,
                       FLAG_FILTERS,
                       :junkwords,
                       :charstrip, :whitespace
                     ].flatten,

    ###############
    # dir options #
    ###############

    :dir_glob  => '*',
    :recursive => false,

    ##################
    # global options #
    ##################

    :nocolor => false,
    :verbose => 0
  }

  require 'fixnames/debug'
  include Debug

  require 'fixnames/interface'
end


