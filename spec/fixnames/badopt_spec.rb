require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Fixnames::Option do
  context "when setting new options" do
    describe "should allow bool types" do
      it_should_allow_bool_option 'recursive'
      it_should_allow_bool_option 'hack_and'
      it_should_allow_bool_option 'and_to_dash'
      it_should_allow_bool_option 'checksums'
      it_should_allow_bool_option 'banners'
      it_should_allow_bool_option 'brackets'
      it_should_allow_bool_option 'semicolon'
      it_should_allow_bool_option 'fix_dots'
      it_should_allow_bool_option 'fix_dashes'
      it_should_allow_bool_option 'fix_numsep'
      it_should_allow_bool_option 'camelcase'
      it_should_allow_bool_option 'lowercase'
      it_should_allow_bool_option 'charstrip_allow_brackets'
      it_should_allow_bool_option 'pretend'
    end

    describe "should allow integer types" do
      it_should_allow_option 'max_filter_loops', 10
    end

    describe "should allow string types" do
      it_should_allow_option 'dir_glob', '*foo*'
      it_should_allow_option 'expunge', '^(\d\d+)'
      it_should_allow_option 'mendstr', '\1-'
      it_should_allow_option 'charstrip', '!@#$%^&()_+-='
      it_should_allow_option 'whitespace', " \t\n"
      it_should_allow_option 'bracket_characters_open',  "`\\"
      it_should_allow_option 'bracket_characters_close', "'/"
    end

    describe "should allow array types" do
      it_should_allow_option 'junkwords',    ['foo','bar','baz']
      it_should_allow_option 'banner_types', ['foo','bar','baz']
      it_should_allow_option 'filter_order', Fixnames::Option::DEFAULT_FILTER_ORDER.sort
    end

    describe "should reject invalid non-bool types for bool options" do
      [ 'recursive',
        'hack_and',
        'and_to_dash',
        'checksums',
        'banners',
        'brackets',
        'semicolon',
        'fix_dots',
        'fix_dashes',
        'fix_numsep',
        'camelcase',
        'lowercase',
        'charstrip_allow_brackets',
        'pretend'
      ].each do |opt_name|
        it_should_reject_nonbool_option(opt_name)
      end
    end

    describe "should reject invalid non-integer types for integer options" do
      [ 'max_filter_loops'
      ].each do |opt_name|
        it_should_reject_noninteger_option(opt_name)
      end
    end

    describe "should reject invalid non-string types for string options" do
      [ 'dir_glob',
        'expunge',
        'mendstr',
        'charstrip',
        'whitespace',
        'bracket_characters_open',
        'bracket_characters_close'
      ].each do |opt_name|
        it_should_reject_nonstring_option(opt_name)
      end
    end

    describe "should reject invalid non-array types for array options" do
      [ 'junkwords',
        'banner_types',
        'filter_order'
      ].each do |opt_name|
        it_should_reject_nonarray_option(opt_name)
      end
    end
  end
end
