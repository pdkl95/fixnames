require 'rubygems'
require 'test/unit'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'fixnames'

class Test::Unit::TestCase
  def fixopt_global
    { }
    # { :verbose => 3 }
  end

  def obj(str)
    FixFileNames.new str, FixFileNames::DEFAULT_OPTIONS.merge(fixopt_global).merge(testopt)
  end

  def fix(str)
    obj(str).fixed
  end

  def assert_nofix(str)
    assert_equal str, fix(str), "Expected NO FIXES to affect the filename."
  end

  def fixed_is(val=nil)
    @fixed_is ||= val if val
    @fixed_is
  end

  def assert_fix(orig, fixed=fixed_is)
    assert_equal fixed, fix(orig)
  end
end
