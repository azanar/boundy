module DateRange
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

        attr_reader :date

        def to_sql_timestamp
          raise "You shouldn't be calling me!"
        end
      end
    end
  end
end
