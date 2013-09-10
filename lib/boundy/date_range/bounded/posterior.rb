require 'boundy/bound'
require 'boundy/bound/infinite' 

module Boundy::DateRange
  class Bounded
    class Posterior < Bounded
      class MidnightAligned < Boundy::DateRange::Bounded::Posterior
        def initialize(date)
          if date.nil?
            raise
          end

          @from = Boundy::Bound::Infinite::Below.new
          @to = case date
                  when Time
                    Boundy::Bound.new(date.end_of_day)
                  when Boundy::Bound
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

        @from = Boundy::Bound::Infinite::Below.new
        @to = case date
                when Time
                  Boundy::Bound.new(date)
                when Boundy::Bound
                  date.dup
                else
                  raise
                end
      end

      def to_sql_clause
        "<= '#{@to.to_sql_timestamp}'"
      end
    end
  end
end
