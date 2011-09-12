require 'fixnames/debug'
require 'fixnames/helpers'
require 'fixnames/filters'
require 'fixnames/engine/scan_dir'

module Fixnames
  class Engine
    include Debug
    include Helpers
    include Filters

    attr_reader :orig, :fixed, :dir, :option
    alias_method :to_s, :fixed

    def initialize(name, opts=Hash.new)
      @option = ::Fixnames::DEFAULT_OPTIONS.merge(opts)

      option[:verbose] ||= 0
      option[:mendstr] ||= ''

      @dir  = File.dirname(name)
      @orig = File.basename(name)

      if option[:recursive] && File.directory?(@orig)
        @scandir = ScanDir.new(@orig, option)
      end

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

    def orig_path
      "#{dir}/#{orig}"
    end

    def fixed_path
      "#{dir}/#{fixed}"
    end

    def scandir_changed?
      @scandir ? @scandir.changed? : false
    end

    def changed?
      fixed != orig
    end

    def collision?
      File.exists? fixed_path
    end

    def fix!
      @scandir.fix! if @scandir

      if changed?
        if collision?
          warn "NAME COLLISION: #{fixed_path.inspect}"
        else
          note "mv #{orig_path.inspect} #{fixed_path.inspect}"
          File.rename orig_path, fixed_path unless option[:pretend]
        end
      else
        info "no change: #{orig_path.inspect}"
      end
      self
    end
  end
end
