require 'boundy/domain'
require 'boundy/bound'
require 'boundy/bound/infinite' 

module Boundy
  class Domain
    # An Anterior domain datum has a beginning, but no end -- hence, is
    # anterior-domain.
    class Anterior < Domain
      class MidnightAligned < Anterior
        def initialize(datum)
          if datum.nil?
            raise
          end

          @from = case datum
                  when ::Time
                    Boundy::Bound.new(datum.beginning_of_day)
                  else
                    raise
                  end
          @to = Boundy::Bound::Infinite::Above.new
        end
      end

      def initialize(datum)
        if datum.nil?
          raise
        end

        @from = case datum
                when ::Time
                  Boundy::Bound.new(datum)
                when Boundy::Bound
                  datum.dup
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
