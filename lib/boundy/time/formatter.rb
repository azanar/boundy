require 'punchout'
require 'punchout/matcher/class'

require 'boundy/bound/formatter'

module Boundy
  class Time
    class Formatter
      class Factory
        def initialize(format)
          @format = format
        end

        def build(time)
          Boundy::Time::Formatter.new(@format, time)
        end

        def format
          raise "I'm a factory! I can't format anything!"
        end
      end

      def self.type
        ::Time
      end

      def self.factory
        Factory
      end

      include Boundy::Bound::Formatter

      def initialize(format, time)
        @formatted = time.strftime(format)
      end

      def to_s
        @formatted
      end
    end
  end
end
