def fixed_for(x)
  Fixnames.new(x, Fixnames::DEFAULT_OPTIONS.merge(@testopt || { })).fixed
end

def it_should_not_change(*args)
  args.each do |x|
    specify "unchanged: #{x.inspect}" do
      x.should eq(fixed_for(x))
    end
  end
end

def it_should_fix(*args)
  args.each do |x|
    specify "produces #{subject.call.inspect} when fixing: #{x.inspect}" do
      subject.should eq(fixed_for(x))
    end
  end
end
