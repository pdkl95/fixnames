require 'fixnames/engine'

module Fixnames
  module Interface
    def parse(name, opts=Hash.new)
      Engine.new(name, opts)
    end

    def fix_name(*args)
      parse(*args).fixed
    end

    def fix!(*args)
      fixed = parse(*args)
      fixed.fix!
    end

    def fix_files!(list, *args)
      list.map do |x|
        fix! x, *args
      end
    end
  end
end
