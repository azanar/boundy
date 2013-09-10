require 'boundy/date_range/bounded'
require 'boundy/bound'
require 'boundy/bound/infinite' 

module Boundy::DateRange
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
                    Boundy::Bound.new(date.beginning_of_day)
                  else
                    raise
                  end
          @to = Boundy::Bound::Infinite::Above.new
        end
      end

      def initialize(date)
        if date.nil?
          raise
        end

        @from = case date
                when Time
                  Boundy::Bound.new(date)
                when Boundy::Bound
                  date.dup
                else
                  raise
                end
        @to = Boundy::Bound::Infinite::Above.new
      end

      def to_sql_clause
        ">= '#{@from.to_sql_timestamp}'"
      end
    end
  end
end
