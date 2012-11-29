require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Fixnames do
  context "when option[:fix_numsep] is TRUE" do
    before do
      @testopt.fix_numsep = true
    end

    describe "should replace \"_\" with \"-\" after leading digits" do
      subject { '42-foo_bar-3_quux.baz' }
      it_should_fix '42_foo_bar-3_quux.baz'
      it_should_not_change 'prefix-42_foo_bar-3_quux.baz'
      it_should_not_change 'prefix_42_foo_bar-3_quux.baz'
    end
  end

  context "when option[:fix_numsep] is FALSE" do
    before do
      @testopt.fix_numsep = false
    end

    describe "should not replace \"_\" with \"-\" after leading digits" do
      it_should_not_change '42_foo_bar-3_quux.baz'
    end
  end
end
