require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Fixnames do
  context "when only option[:whitespace] is non-nil" do
    before do
      @testopt.fix_dashes = false
      @testopt.whitespace = Fixnames::Option::DEFAULT_WHITESPACE
    end

    describe "should preserve simple names" do
      it_should_not_change 'abc', 'a-b', 'a.b'
    end

    describe "should convert all spaces to underscores" do
      subject { 'ab_c' }
      it_should_fix 'ab c'
    end

    describe "should convert all tabs to underscores" do
      subject { 'ab_c' }
      it_should_fix "ab\tc"
    end

    describe "should pass single underscores unchanged" do
      it_should_not_change 'a_b'
    end

    describe "should collapse multiple spaces" do
      subject { 'a_b' }
      it_should_fix 'a  b', 'a   b', 'a    b'
    end

    describe "should collapse dash-underscore pairs to a dash" do
      subject { 'a-b' }
      it_should_fix 'a-_b', 'a_-b', 'a_-_b'
    end

    describe "should collapse multiple underscores to a single character" do
      subject { 'a_b' }
      it_should_fix 'a__b', 'a___b', 'a____b'
    end

    describe "should collapse multiple mixed whitespaces characters to a single underscore" do
      subject { 'a_b' }
      it_should_fix 'a_ b', 'a _b', 'a _ b', 'a_ _b'
    end

    describe "should erase trailing whitespace" do
      subject { 'ab' }
      it_should_fix 'ab ',  'ab_',  'ab_ ', 'ab _', 'ab__', 'ab  '
    end

    describe "should erase leading whitespace" do
      subject { 'ab' }
      it_should_fix ' ab', '_ab', '_ ab', ' _ab', '__ab', '  ab'
    end

    describe "should pass a single dot unchanged" do
      it_should_not_change 'abc.d', 'ab_c.d', 'a-bc.d'
    end

    describe "should remove whitespace preceding a dot" do
      subject { 'a.b' }
      it_should_fix  'a .b',   'a_.b'
      it_should_fix 'a  .b',  'a _.b'
      it_should_fix 'a__.b', 'a _ .b'
    end

    describe "should remove whitespace around a single dash" do
      subject { 'a-b' }
      it_should_fix 'a- b',  'a-_b', 'a -b',  'a_-b'
      it_should_fix 'a_-_b', 'a - b', 'a_- b', 'a -_b'
    end
  end
end
