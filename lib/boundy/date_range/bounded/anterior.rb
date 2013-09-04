require 'boundy/date_range/bounded/bound'

module DateRange
  class Bounded
    # An Anterior bounded date has a beginning, but no end -- hence, is
    # anterior-bounded.
    class Anterior < Bounded
      class MidnightAligned < Anterior
        def initialize(date)
          if date.nil?
            raise
          end

          @from = case date
                  when Time
                    Bound.new(date.beginning_of_day)
                  else
                    raise
                  end
          @to = Bound::Infinite.new
        end
      end

      def initialize(date)
        if date.nil?
          raise
        end

        @from = case date
                when Time
                  Bound.new(date)
                when Bound
                  date.dup
                else
                  raise
                end
        @to = Bound::Infinite.new
      end

      def to_sql_clause
        ">= #{to_sql_timestamp}"
      end
    end
  end
end
