require 'boundy'
require 'boundy/formatter/sql/plugin'

require 'punchout'

require 'boundy/formatter/sql/factory'

module Boundy
  module Formatter
    class Sql
      def initialize(obj, name)
        formatter_factory = Plugin.for(obj)
        if formatter_factory.nil?
          raise "No formatter registered for #{obj.class}: #{obj.inspect}"
        end
        @formatter = formatter_factory.build(obj, name)
      end

      def to_s
        @formatter.to_s
      end
    end
  end
end

require 'boundy/formatters/sql/domain'
