require 'boundy/formatter/sql/domain/plugin'

module Boundy
  module Formatter
    class Sql
      class Domain
        def initialize(obj, name)
          @formatter = Plugin.for(obj).new(obj,name)
          if @formatter.nil?
            raise "No formatter registered for #{obj.inspect}"
          end
        end

        def to_s
          @formatter.to_s
        end
      end
    end
  end
end
