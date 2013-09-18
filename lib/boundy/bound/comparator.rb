require 'boundy/bound'
require 'boundy/bound/infinite' 

module Boundy
  class Bound
    class Comparator
      def initialize(a, b)
        @a = a
        @b = b
      end

      Bound = Boundy::Bound

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

      def before?
        compare == :left 
      end

      def after?
        compare == :right
      end

      def within?
        compare == :equal
      end

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
          map[@a.datum <=> @b.datum]
        else
          result
        end

      end
    end
  end
end
