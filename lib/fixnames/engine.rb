require 'fixnames/debug'
require 'fixnames/helpers'
require 'fixnames/filters'

module Fixnames
  class Engine
    include Debug
    include Helpers
    include Filters

    attr_reader :orig, :fixed, :option
    alias_method :to_s, :fixed

    def initialize(name, opts=Hash.new, pattern_opts=Hash.new)
      @option = ::Fixnames::DEFAULT_OPTIONS.merge(opts)

      option[:verbose] ||= 0
      option[:mendstr] ||= ''

      @orig  = name.to_s.dup
      @fixed = @orig.dup

      option[:filter_order].each do |optname|
        if option[optname] and respond_to?(optname)
          debug "FILTER[:#{optname}]"
          old = fixed.dup
          case method(optname).arity
          when 1 then send optname, option[optname]
          when 0 then send optname
          else raise "Unsupported arity in ##{optname}"
          end
          if old != fixed
            debug "\t    old -- #{old.inspect}"
            debug "\t    new -- #{fixed.inspect}"
          end
        end
      end
    end

    def changed?
      fixed != orig
    end

    def collision?
      File.exists? fixed
    end

    def fix!
      if changed?
        if collision?
          warn "NAME COLLISION: #{fixed.inspect}"
        else
          note "mv #{orig.inspect} #{fixed.inspect}"
          File.rename orig, fixed unless option[:pretend]
        end
      else
        info "no change: #{orig.inspect}"
      end
      self
    end
  end
end
