def it_should_not_change(*args)
  args.each do |x|
    specify "unchanged: #{x.inspect}" do
      x.should eq(Fixnames.new(x).fixed)
    end
  end
end

def it_should_fix(*args)
  args.each do |x|
    specify "produces #{subject.call.inspect} when fixing: #{x.inspect}" do
      subject.should eq(Fixnames.new(x).fixed)
    end
  end
end
