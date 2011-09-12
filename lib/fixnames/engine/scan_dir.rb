module Fixnames
  class Engine
    class ScanDir
      attr_reader :option, :name, :base, :prefix
      def initialize(dirname, opts)
        raise "Not a directory: #{dirname}" unless File.directory?(dirname)
        @name = File.realpath(dirname)
        raise "Not a directory: #{name}" unless File.directory?(name)

        @option = ::Fixnames::DEFAULT_OPTIONS.merge(opts)
      end

      def glob_str
        "#{name}/#{option[:dir_glob]}"
      end

      def files
        @files ||= Dir.glob(glob_str)
      end

      def engines
        @engies ||= files.map do |name|
          Engine.new(name, option)
        end
      end

      def fix!
        engines.map do |en|
          en.fix!
        end
      end
    end
  end
end
