require 'boundy/formatter/sql/plugin'

require 'boundy/formatters/bound'
require 'boundy/formatters/time'

module Boundy
  module Formatters
    class Time
      class Factory
        def initialize(format)
          @format = format
        end

        def build(time, name)
          Boundy::Formatters::Time.new(@format, time)
        end
      end

      def self.type
        ::Time
      end


      class << self
        def factory
          @factory = Factory.new("%Y-%m-%d %H:%M:%S")
        end
        attr_writer :factory
      end

      include Boundy::Formatter::Sql::Plugin

      def initialize(format, time)
        @formatted = time.strftime(format)
      end

      def to_s
        @formatted
      end
    end
  end
end
