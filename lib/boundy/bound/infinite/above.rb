module Boundy
  class Bound
    class Infinite
      class Above < Infinite
        include Comparable
        def <=>(other)
          -1 
        end
      end
    end
  end
end
