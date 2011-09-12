def fixed_for(x)
  Fixnames::FixFile.fix_name x, @testopt
end

def it_should_not_change(*args)
  args.each do |x|
    specify "unchanged: #{x.inspect}" do
      fixed_for(x).should eq(x)
    end
  end
end

def it_should_fix(*args)
  args.each do |x|
    specify "produces #{subject.call.inspect} when fixing: #{x.inspect}" do
      fixed_for(x).should eq(subject)
    end
  end
end
