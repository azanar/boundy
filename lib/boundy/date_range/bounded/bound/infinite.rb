module Boundy::DateRange
  class Bounded
    # An Anterior bounded date has a beginning, but no end -- hence, is
    # anterior-bounded.
    class Bound
      class Infinite
        def after?(date_range)
          false
        end

        def before?(date_range)
          false
        end

        def within?(date_range)
          true
        end

        def in_time_zone(tz)
          self
        end

        def to_midnight
          self
        end

        def date
          nil
        end

        def <=>(other)
          raise ""
        end

        def to_sql_timestamp
          raise "You shouldn't be calling me!"
        end
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
end
