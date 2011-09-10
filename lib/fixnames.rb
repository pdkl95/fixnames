module Fixnames
  DEFAULT_OPTIONS = {
    :expunge => nil,
    :mendstr => nil,

    :hack_and   => false,
    :checksums  => false,
    :banners    => false,

    :brackets   => false,
    :semicolon  => false,
    :fix_dots   => false,

    :camelcase  => false,
    :lowercase  => false,

    :charstrip  => "[]{}'\",()+!~@#/\\",
    :whitespace => " \t_",

    :banner_types => [ 'xxx', 'dvdrip', 'dual_audio',
                       'xvid', 'h264', 'divx'
                     ],

    :charstrip_allow_brackets => false,
    :bracket_characters_open  => '[({<',
    :bracket_characters_close => '])}>',

    :filter_order => [ :expunge,
                       :hack_and, :checksums, :banners,
                       :brackets, :semicolon, :fix_dots,
                       :camelcase, :lowercase,
                       :charstrip, :whitespace
                     ],

    :nocolor => false,
    :verbose => 0
  }

  require 'fixnames/debug'
  include Debug

  require 'fixnames/interface'
  extend Interface
end


