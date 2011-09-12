require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Fixnames do
  context "when option[:fix_dots] is TRUE" do
    before do
      @testopt.fix_dots = true
    end

    describe "should replace early dots with underbars" do
      subject { 'file_name.txt' }
      it_should_fix 'file.name.txt'
    end

    describe "should compress neighboring dots to a single character" do
      subject { 'file.txt' }
      it_should_fix 'file..txt', 'file...txt', 'file....txt'
    end
  end

  context "when option[:fix_dots] is FALSE" do
    before do
      @testopt.fix_dots = false
    end

    describe "should allow multiple dots" do
      it_should_not_change 'file.name.txt'
      it_should_not_change 'file..txt', 'file...txt', 'file....txt'
    end
  end
end
