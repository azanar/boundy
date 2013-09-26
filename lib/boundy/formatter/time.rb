require 'punchout'
require 'punchout/matcher/class'

require 'boundy/formatter/bound'
require 'boundy/formatter/time'

module Boundy
  module Formatter
    class Time
      class Factory
        def initialize(format)
          @format = format
        end

        def build(time)
          Boundy::Formatter::Time.new(@format, time)
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

      include Boundy::Formatter::Bound

      def initialize(format, time)
        @formatted = time.strftime(format)
      end

      def to_s
        @formatted
      end
    end
  end
end
