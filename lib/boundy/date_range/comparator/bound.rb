require 'boundy/date_range/bounded/bound'
require 'boundy/date_range/bounded/bound/infinite' 

module Boundy
  module DateRange
    module Comparator
      class Bound
        def initialize(a, b)
          @a = a
          @b = b
        end
        
        Bound = Boundy::DateRange::Bounded::Bound

        COMPARISONS = {
          Bound::Infinite::Above => {
             Bound::Infinite::Above => :equal,
             Bound::Infinite::Below => :left,
             Bound => :left
          },
          Bound::Infinite::Below => {
             Bound::Infinite::Above => :right,
             Bound::Infinite::Below => :equal,
             Bound => :right
          },
          Bound => {
             Bound::Infinite::Above => :right,
             Bound::Infinite::Below => :left 
          }
        }

        def compare
          result = nil
          if COMPARISONS.has_key?(@a.class)
            part_comp = COMPARISONS[@a.class]
            if part_comp.has_key?(@b.class)
              result = part_comp[@b.class]
            end
          end
          
          map = {
            -1 => :right,
            0 => :equal,
            1 => :left
          }

          if result.nil?
            map[@a <=> @b]
          else
            result
          end

        end
      end
    end
  end
end

