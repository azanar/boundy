require 'boundy/bound/comparator'

module Boundy
  class Bound
    class Constrainer
      def initialize(a, b)
        @a = a
        @b = b
        @comparator = Boundy::Bound::Comparator.new(a,b)
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
