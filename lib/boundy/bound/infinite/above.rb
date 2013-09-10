module Boundy
  class Bound
    class Infinite
      class Above < Infinite
        include Comparable
        def max_of(other)
          self
        end

        def min_of(other)
          other
        end

        def <=>(other)
          -1 
        end
      end
    end
  end
end
