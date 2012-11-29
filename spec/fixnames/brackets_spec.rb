require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Fixnames do

  ##########################################################################
  context "when option[:brackets] is TRUE" do
    before do
      @testopt.brackets = true
      @testopt.fix_dashes = true
    end

    describe "should replace bracket pairs with a dash" do
      subject { 'foo-x-bar' }
      it_should_fix 'foo[x]bar'
      it_should_fix 'foo[ x ]bar'
      it_should_fix 'foo[-x-]bar'
      it_should_fix 'foo[_x_]bar'
      it_should_fix 'foo [x] bar'
      it_should_fix 'foo-[x]-bar'
      it_should_fix 'foo_[x]_bar'
    end

    describe "should replace multiple bracket pairs" do
      subject { 'foo-bar-baz-quux' }
      it_should_fix 'foo(bar)baz<quux>'
      it_should_fix 'foo(bar)[baz]quux'
      it_should_fix 'foo(-bar-)baz<_quux_>'
      it_should_fix 'foo-(bar)-baz-<quux>'
      it_should_fix 'foo (bar) baz <quux>'
      it_should_fix '{ foo }-( bar )-[ baz ]-< quux >'
      it_should_fix '[ foo ]<->[ bar ]<->[ baz ]<->[ quux ]'
    end
  end

  ##########################################################################
  context "when option[:brackets] is FALSE and option[:charstrip] strips brackets" do
    before do
      @testopt.brackets = false
      @testopt.charstrip_allow_brackets = false
    end

    describe "should strip a single bracket pair" do
      subject { 'fooxbar' }
      it_should_fix 'foo[x]bar'
      it_should_fix 'foo(x)bar'
      it_should_fix 'foo<x>bar'
      it_should_fix '[foo]xbar'
      it_should_fix 'fooxba[r]'
      it_should_fix '[fooxbar]'
    end

    describe "should strip a single bracket pair near dashes" do
      subject { 'foo-x-bar' }
      it_should_fix 'foo[-x-]bar'
      it_should_fix 'foo-[x]-bar'
      it_should_fix '[foo]-x-bar'
      it_should_fix '[foo-x-]bar'
      it_should_fix 'foo-x[-bar]'
    end

    describe "should strip a single bracket pair near undebars" do
      subject { 'foo_x_bar' }
      it_should_fix 'foo[_x_]bar'
      it_should_fix 'foo_[x]_bar'
      it_should_fix '[foo_]x_bar'
      it_should_fix 'foo[_x_bar]'
    end

    describe "should strip multiple bracket pairs" do
      subject { 'foobarbazquux' }
      it_should_fix 'foo(bar)baz[quux]'
      it_should_fix '{foo}(bar)<baz>[quux]'
    end

    describe "should strip multiple brack pairs with dashes" do
      subject { 'foo-bar-baz-quux' }
      it_should_fix 'foo-bar-baz-quux'
      it_should_fix 'foo-(b)ar-[baz-]quux'
      it_should_fix 'foo<->bar[-]baz(-)quux'
      it_should_fix '[foo]-[bar]-[baz]-[quux]'
    end
  end

  ##########################################################################
  context "when option[:brackets] is FALSE and option[:charstrip] sllows brackets" do
    before do
      @testopt.brackets = false
      @testopt.charstrip_allow_brackets = true
    end

    describe "should replace ALLOW bracket expressions" do
      it_should_not_change 'foo[x]bar'
      it_should_not_change 'foo[-x-]bar'
      it_should_not_change 'foo[_x_]bar'
      it_should_not_change 'foo-[x]-bar'
      it_should_not_change 'foo_[x]_bar'
      it_should_not_change 'fo(foo)ob<bar>ar'
      it_should_not_change 'fo(-foo-)ob<_bar_>ar'
      it_should_not_change 'fo-(foo)-ob-<bar>-ar'
    end
  end
end
