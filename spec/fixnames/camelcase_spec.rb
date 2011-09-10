require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Fixnames do
  context "when option[:camelcase] is TRUE" do
    before do
      @testopt = { :camelcase => true }
    end

    describe "should replace camelCase with underscore_case" do
      subject { 'foo_bar' }
      it_should_fix 'fooBar'
    end
  end

  context "when option[:camelcase] is FALSE" do
    before do
      @testopt = { :camelcase => false }
    end

    describe "should allow aA style case patterns" do
      it_should_not_change 'xYzZy', 'fooBarBaz'
    end
  end
end
