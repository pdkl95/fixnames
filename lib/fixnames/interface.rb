require 'fixnames/engine'

module Fixnames
  module FixFile
    def self.parse(name, opts=Hash.new)
      Engine.new(name, opts)
    end

    def self.fix_name(*args)
      parse(*args).fixed
    end

    def self.fix!(*args)
      parse(*args).fix!
    end

    def self.fix_list!(list, *args)
      list.map do |x|
        fix! x, *args
      end
    end
  end

  module FixDir
    def self.parse(name, opts=Hash.new)
      Engine::ScanDir.new(name, opts)
    end

    def self.fix!(*args)
      parse(*args).fix!
    end

    def self.fix_list!(list, *args)
      list.map do |x|
        fix! x, *args
      end
    end
  end
end
