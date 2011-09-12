require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Fixnames do
  context "when option[:brackets] is TRUE" do
    before do
      @testopt.brackets = true
    end

    describe "should remove bracket expressions" do
      subject { 'foobar' }
      it_should_fix 'foo[x]bar', 'fo(foo)ob<bar>ar'
      it_should_fix 'foo[ x ]bar', 'fo(-foo-)ob<_bar_>ar'
    end
  end

  context "when option[:brackets] is FALSE" do
    before do
      @testopt.brackets = false
      @testopt.charstrip_allow_brackets = true
    end

    describe "should replace ALLOW bracket expressions" do
      it_should_not_change 'foo[x]bar', 'fo(foo)ob<bar>ar'
    end
  end
end
