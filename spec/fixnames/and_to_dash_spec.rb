require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Fixnames do
  context "when option[:and_to_dash] is TRUE" do
    before do
      @testopt.and_to_dash = true
    end

    describe "should replace \"_and_\" with \"-\"" do
      subject { 'a-b' }
      it_should_fix 'a_and_b', 'a and b', 'a-and-b'
      it_should_fix 'a-and_b', 'a_and-b'
      it_should_fix 'a-and b', 'a and-b'
      it_should_fix 'a and_b', 'a_and b'

      it_should_fix 'a    and    b'
      it_should_fix 'a- -and- -b'
      it_should_fix 'a- _and_ -b'
      it_should_fix 'a__and__b'
      it_should_fix 'a_-_and_-_b'
      it_should_fix 'a - and - b'
    end
  end

  context "when option[:and_to_dash] is FALSE" do
    before do
      @testopt.and_to_dash = false
    end

    describe "should replace ALLOW \"&\"" do
      it_should_not_change 'a_and_b'
    end
  end
end
