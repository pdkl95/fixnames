require 'helper'

class TestWhitespace < Test::Unit::TestCase
  def testopt
    { :hack_and => true }
  end

  def test_hack
    fixed_is 'a_and_b'

    assert_fix 'a&b'
    assert_fix 'a & b'
    assert_fix 'a_&_b'
    assert_fix 'a &_b'
    assert_fix 'a_& b'
  end
end
