def it_should_allow_option(opt_name, value)
  specify "new value allowd: option.#{opt_name}(#{value.inspect})" do
    expect do
      @testopt.send(opt_name, value)
    end.not_to raise_error(ArgumentError)
  end
  specify "new value allowd: option.#{opt_name} = #{value.inspect}" do
    expect do
      @testopt.send("#{opt_name}=", value)
    end.not_to raise_error(ArgumentError)
  end
end

def it_should_allow_bool_option(opt_name)
  it_should_allow_option(opt_name, true)
  it_should_allow_option(opt_name, false)
end

def it_should_reject_option(opt_name, *values)
  values.each do |value|
    specify "new value rejected: option.#{opt_name}(#{value.inspect})" do
      expect do
        @testopt.send(opt_name, value)
      end.to raise_error(ArgumentError)
    end
    specify "new value rejected: option.#{opt_name} = #{value.inspect}" do
      expect do
        @testopt.send("#{opt_name}=", value)
      end.to raise_error(ArgumentError)
    end
  end
end


def it_should_reject_nonbool_option(opt_name)
  it_should_reject_option opt_name, 123, 'foo', ['foo','bar','baz']
end

def it_should_reject_noninteger_option(opt_name)
  it_should_reject_option opt_name, true, 'foo', ['foo','bar','baz']
end

def it_should_reject_nonstring_option(opt_name)
  it_should_reject_option opt_name, true, 123, ['foo','bar','baz']
end

def it_should_reject_nonarray_option(opt_name)
  it_should_reject_option opt_name, true, 123, 'foo'
end

