require 'boundy/date_range/comparator/bound'

module Boundy
  module DateRange
    class Bounded
      class Bound
        class Constrainer
          def initialize(a, b)
            @a = a
            @b = b
            @comparator = Boundy::DateRange::Comparator::Bound.new(a,b)
          end

          def max
            if @comparator.compare == :left
              @a
            else
              @b
            end
          end

          def min
            if @comparator.compare == :right
              @a
            else
              @b
            end
          end
        end
      end
    end
  end
end
