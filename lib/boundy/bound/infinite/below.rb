module Boundy
  class Bound
    class Infinite
      class Below < Infinite
        include Comparable
        def max_of(other)
          other
        end

        def min_of(other)
          self
        end

        def <=>(other)
          1
        end
      end
    end
  end
end

