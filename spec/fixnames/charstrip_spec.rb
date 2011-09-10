require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Fixnames do
  context "when option[:charstrip] is non-nil" do
    describe "should allow common filename characters" do
      it_should_not_change 'abc', 'a_b', 'a-b', 'a.b'
    end

    describe "should strip most punctuation" do
      subject { 'ab' }
      it_should_fix 'a[b', 'a]b'
      it_should_fix 'a{b', 'a}b'
      it_should_fix 'a(b', 'a)b'
      it_should_fix 'a\'b', 'a"b'
      it_should_fix 'a/b', "a\\b"
      it_should_fix 'a,b', 'a+b'
      it_should_fix 'a!b', 'a~b'
      it_should_fix 'a#b', 'a@b'
    end
  end
end
