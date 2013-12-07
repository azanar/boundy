module Boundy
  module Formatter
    class Sql
      class Factory
        def initialize(klass)
          @klass = klass
        end
        def build(obj, name)
          @klass.new(obj, name)
        end
      end
    end
  end
end
