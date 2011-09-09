require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Fixnames do
  context "using the semicolon filter" do
    before do
      @testopt = { :semicolon => true }
    end

    describe "should replace semicolons and surrounding whitespace with a single dash" do
      subject { 'a-b' }
      it_should_fix 'a;b', 'a; b', 'a ;b', 'a ; b', 'a-; b', 'a ;-b'
    end
  end

  context "semicolon filter is disabled" do
    before do
      @testopt = { :semicolon => false }
    end

    describe "should ALLOW semicolons" do
      it_should_not_change 'a;b'
    end
  end
end
