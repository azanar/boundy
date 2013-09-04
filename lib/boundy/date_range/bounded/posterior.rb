require 'boundy/date_range/bounded/bound'

module DateRange
  class Bounded
    class Posterior < Bounded
      class MidnightAligned < Posterior
        def initialize(date)
          if date.nil?
            raise
          end

          @from = Bound::Infinite.new
          @to = case date
                  when Time
                    Bound.new(date.end_of_day)
                  when Bound
                    date.dup
                  else
                    raise
                  end
        end
      end

      def initialize(date)
        if date.nil?
          raise
        end

        @from = Bound::Infinite.new
        @to = case date
                when Time
                  Bound.new(date)
                when Bound
                  date.dup
                else
                  raise
                end
      end

      def to_sql_clause
        "<= #{to_sql_timestamp}"
      end
    end
  end
end
