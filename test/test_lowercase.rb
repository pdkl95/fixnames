require 'helper'

class TestLowercase < Test::Unit::TestCase
  def testopt
    { :lowercase => true }
  end

  def test_lowercase
    assert_nofix 'ab_c'
    assert_nofix 'ab-c'
    assert_nofix 'ab.c'
  end

  def test_uppercase
    assert_fix 'ABC', 'abc'
    assert_fix 'AB_C', 'ab_c'
    assert_fix 'AB-C', 'ab-c'
    assert_fix 'AB.C', 'ab.c'
  end
end
