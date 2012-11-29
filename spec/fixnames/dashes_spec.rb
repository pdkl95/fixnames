require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Fixnames do
  context "when only option[:dashes] is non-nil" do
    before do
      @testopt.fix_dashes = true
      @testopt.whitespace = nil
    end

    describe "should preserve single dashes between letters" do
      it_should_not_change 'a-b'
    end

    describe "should pass single underscores unchanged" do
      it_should_not_change 'a_b'
    end

    describe "should not duplicate the :whitesapce filter and collapse dashe-underscores pairs to a dash" do
      it_should_not_change 'a-_b', 'a_-b', 'a_-_b'
    end

    describe "should collapse multiple dashes to a single character" do
      subject { 'a-b' }
      it_should_fix 'a--b', 'a---b', 'a----b'
    end

    describe "should remove dashes near a dot" do
      subject { 'a.b' }
      it_should_fix  'a-.b', 'a.-b',   'a-.-b'
      it_should_fix 'a--.b', 'a.--b', 'a--.--b'
    end
  end
end
