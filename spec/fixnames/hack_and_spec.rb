require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Fixnames do
  context "using the hack-and filter" do
    before do
      @testopt = { :hack_and => true }
    end

    describe "should replace \"&\" with \"_and_\"" do
      subject { 'a_and_b' }
      it_should_fix 'a&b', 'a & b', 'a_&_b', 'a &_b', 'a_& b'
    end
  end

  context "hack-and filter is disabled" do
    before do
      @testopt = { :hack_and => false }
    end

    describe "should replace ALLOW \"&\"" do
      it_should_not_change 'a&b'
    end
  end
end
