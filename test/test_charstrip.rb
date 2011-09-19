require 'helper'

class TestCharstrip < Test::Unit::TestCase
  def testopt
    { }
  end

  def test_nospace
    assert_nofix 'abc'
    assert_nofix 'a_b'
    assert_nofix 'a-b'
    assert_nofix 'a.b'
  end

  def test_charstrip
    fixed_is 'ab'

    assert_fix 'a[b'
    assert_fix 'a]b'
    assert_fix 'a{b'
    assert_fix 'a}b'
    assert_fix 'a(b'
    assert_fix 'a)b'
    assert_fix 'a\'b'
    assert_fix 'a"b'
    assert_fix 'a,b'
    assert_fix 'a+b'
    assert_fix 'a!b'
    assert_fix 'a~b'
    assert_fix 'a/b'
    assert_fix "a\\b"
    assert_fix 'a#b'
    assert_fix 'a@b'
  end
end
