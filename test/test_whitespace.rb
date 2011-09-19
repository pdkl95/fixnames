require 'helper'

class TestWhitespace < Test::Unit::TestCase
  def testopt
    { }
  end

  def test_nospace
    assert_nofix 'abc'
    assert_nofix 'a-b'
    assert_nofix 'a.b'
  end

  def test_space
    assert_fix 'ab c', 'ab_c'
  end

  def test_tab
    assert_fix "ab\tc", 'ab_c'
  end

  def test_underscore
    assert_nofix 'a_b'
  end

  def test_multi_space
    fixed_is 'a_b'

    assert_fix 'a  b'
    assert_fix 'a   b'
    assert_fix 'a    b'
  end

  def test_muti_underscore
    fixed_is 'a_b'

    assert_fix 'a__b'
    assert_fix 'a___b'
    assert_fix 'a____b'
  end

  def test_mixed_space_underscore
    fixed_is 'a_b'

    assert_fix 'a_ b'
    assert_fix 'a _b'
    assert_fix 'a _ b'
    assert_fix 'a_ _b'
  end

  def test_trailing_whitespace
    fixed_is 'ab'

    assert_fix 'ab '
    assert_fix 'ab_'

    assert_fix 'ab_ '
    assert_fix 'ab _'

    assert_fix 'ab__'
    assert_fix 'ab  '
  end

  def test_leading_whitespace
    fixed_is 'ab'

    assert_fix ' ab'
    assert_fix '_ab'

    assert_fix '_ ab'
    assert_fix ' _ab'

    assert_fix '__ab'
    assert_fix '  ab'
  end

  def test_dots
    assert_nofix 'abc.d'
    assert_nofix 'ab_c.d'
    assert_nofix 'a-bc.d'

    fixed_is 'a.b'

    assert_fix 'a .b'
    assert_fix 'a_.b'
    assert_fix 'a-.b'

    assert_fix 'a  .b'
    assert_fix 'a _.b'
    assert_fix 'a_ .b'
    assert_fix 'a__.b'

    assert_fix 'a _ .b'
    assert_fix 'a- _.b'
  end

  def test_dashes
    fixed_is 'a-b'

    assert_fix 'a- b'
    assert_fix 'a-_b'
    assert_fix 'a -b'
    assert_fix 'a_-b'

    assert_fix 'a_-_b'
    assert_fix 'a - b'
    assert_fix 'a_- b'
    assert_fix 'a -_b'
  end
end
