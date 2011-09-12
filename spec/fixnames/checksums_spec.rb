require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Fixnames do
  context "when option[:checksums] is TRUE" do
    before do
      @testopt.checksums = true
    end

    describe "should remove [1A2B3C4D] style checksum markers" do
      subject { 'foobar' }
      it_should_fix 'foo[1A2B3C4D]bar', 'foo[1a2b3c4d]bar'
      it_should_fix 'foo(1A2B3C4D)bar', 'foo(1a2b3c4d)bar'
      it_should_fix 'foo{1A2B3C4D}bar', 'foo{1a2b3c4d}bar'
    end
  end

  context "when option[:checksums] is FALSE" do
    before do
      @testopt.checksums = false
      @testopt.charstrip_allow_brackets = true
    end

    describe "should allow checksum markers" do
      it_should_not_change 'foo[1A2B3C4D]bar', 'foo[1a2b3c4d]bar'
      it_should_not_change 'foo(1A2B3C4D)bar', 'foo(1a2b3c4d)bar'
      it_should_not_change 'foo{1A2B3C4D}bar', 'foo{1a2b3c4d}bar'
    end
  end
end
