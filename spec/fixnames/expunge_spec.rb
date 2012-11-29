require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Fixnames do
  context "when option[:expunge] is Regexp-formatted string and option[:replace is nil" do
    before do
      @testopt.mendstr = Fixnames::Option::DEFAULT_MENDSTR
     end

    describe "should erase matched fragments" do
       subject { 'foo-242-bar-baz.quux' }
      it_should_expunge_and_match      '-', 'foo242barbaz.quux'
      it_should_expunge_and_match      'b', 'foo-242-ar-az.quux'
      it_should_expunge_and_match    '\d+', 'foo--bar-baz.quux'
      it_should_expunge_and_match '[0-9]+', 'foo--bar-baz.quux'
      it_should_expunge_and_match   '-.*-', 'foobaz.quux'
    end
  end

  context "when options[:expunge] is a Regexp and ootions[:replace] is a string" do
    before do
      @testopt.mendstr = 'X'
    end

    describe "should replace matched fragments" do
      subject { 'foo-242-bar-baz.quux' }
      it_should_expunge_and_match       '-', 'fooX242XbarXbaz.quux'
      it_should_expunge_and_match       'b', 'foo-242-Xar-Xaz.quux'
      it_should_expunge_and_match     '\d+', 'foo-X-bar-baz.quux'
      it_should_expunge_and_match  '[0-9]+', 'foo-X-bar-baz.quux'
      it_should_expunge_and_match    '-.*-', 'fooXbaz.quux'
    end
  end

  context "when options[:expunge] is a Regexp and ootions[:replace] is a string with a backreference" do
    before do
      @testopt.mendstr = '\1-PLUGH'
    end

    describe "should replace matched fragments (including backreferences)" do
      subject { 'foo-242-bar-baz.quux' }
      it_should_expunge_and_match 'foo-(\d+)', '242-PLUGH-bar-baz.quux'
      it_should_expunge_and_match    '(b\w*)', 'foo-242-bar-PLUGH-baz-PLUGH.quux'
    end
  end

  context "when options[:expunge] is a Regexp and ootions[:replace] is a string with multiple backreferences" do
    before do
      @testopt.mendstr = '_\1\2\1_'
    end

    describe "should replace matched fragments (including backreferences)" do
      subject { 'foo-242-bar-baz.quux' }
      it_should_expunge_and_match   '(\d+)-(b\w*)', 'foo-242bar242-baz.quux'
      it_should_expunge_and_match '-(\d+)-(b\w*)-', 'foo_242bar242_baz.quux'
      it_should_expunge_and_match      '(b)(\w\w)', 'foo-242-barb-bazb.quux'
      it_should_expunge_and_match    '-(b)(\w\w)-', 'foo-242_barb_baz.quux'
    end
  end
end
