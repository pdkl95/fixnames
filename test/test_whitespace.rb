require 'helper'

class WhitespaceTest < Test::Unit::TestCase
  context "whitespace filter" do
    setup do
      @testopt = { }
    end

    should "pass simple names unchanged" do
      assert_nofix 'abc'
      assert_nofix 'a-b'
      assert_nofix 'a.b'
    end

    should "convert all spaces to underscores" do
      assert_fix 'ab c', 'ab_c'
    end

    should "convert all tabs to underscores" do
      assert_fix "ab\tc", 'ab_c'
    end

    should "pass single underscores unchanged" do
      assert_nofix 'a_b'
    end

    should "collapse multiple spaces to a single underscore" do
      fixed_is 'a_b'

      assert_fix 'a  b'
      assert_fix 'a   b'
      assert_fix 'a    b'
    end

    should "collapse multiple underscores to a single character" do
      fixed_is 'a_b'

      assert_fix 'a__b'
      assert_fix 'a___b'
      assert_fix 'a____b'
    end

    should "collapse multiple mixed whitespaces characters to a single underscore" do
      fixed_is 'a_b'

      assert_fix 'a_ b'
      assert_fix 'a _b'
      assert_fix 'a _ b'
      assert_fix 'a_ _b'
    end

    should "erase trailing whitespace" do
      fixed_is 'ab'

      assert_fix 'ab '
      assert_fix 'ab_'

      assert_fix 'ab_ '
      assert_fix 'ab _'

      assert_fix 'ab__'
      assert_fix 'ab  '
    end

    should "erase leading whitespace" do
      fixed_is 'ab'

      assert_fix ' ab'
      assert_fix '_ab'

      assert_fix '_ ab'
      assert_fix ' _ab'

      assert_fix '__ab'
      assert_fix '  ab'
    end

    should "pass a single dot unchanged" do
      assert_nofix 'abc.d'
      assert_nofix 'ab_c.d'
      assert_nofix 'a-bc.d'
    end

    should "remove whitespace preceding a dot" do
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

    should "remove whitespace around a single dash" do
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
end
