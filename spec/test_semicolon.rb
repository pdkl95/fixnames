require 'helper'

class TestSemicolon < Test::Unit::TestCase
  def testopt
    { :semicolon => true }
  end

  def test_hack
    fixed_is 'a-b'

    assert_fix 'a;b'
    assert_fix 'a; b'
    assert_fix 'a ;b'
    assert_fix 'a ; b'
    assert_fix 'a-; b'
    assert_fix 'a ;-b'
  end
end
