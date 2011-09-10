require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Fixnames do
  context "when option[:lowercase] is TRUE" do
    before do
      @testopt = { :lowercase => true }
    end

    describe "should allow lowercase" do
      it_should_not_change 'ab_c', 'ab-c', 'ab.c'
    end

    describe "should fix uppercase" do
      subject { 'abc' }
      it_should_fix 'ABC', 'Abc', 'aBc', 'abC'
    end
  end

  context "when option[:lowercase] is FALSE" do
    before do
      @testopt = { :lowercase => false }
    end

    describe "should ALLOW uppercase" do
      it_should_not_change 'ABC', 'Abc', 'aBc', 'abC'
    end
  end
end
