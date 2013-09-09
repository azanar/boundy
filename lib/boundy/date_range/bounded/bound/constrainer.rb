module Boundy::DateRange
  class Bounded
    class Bound
      class Constrainer
        def initialize(a, b)
          @a = a
          @b = b
        end

        def max
          case @a
          when Bound::Infinite::Above
            @a
          when Bound::Infinite::Below
            @b
          else
            case @b
            when Bound::Infinite::Above
              @b
            when Bound::Infinite::Below
              @a
            else
              if @a < @b
                @b
              else
                @a
              end
            end
          end
        end

        def min
          case @a
          when Bound::Infinite::Above
            @b
          when Bound::Infinite::Below
            @a
          else
            case @b
            when Bound::Infinite::Above
              @a
            when Bound::Infinite::Below
              @b
            else
              if @a < @b
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
end

