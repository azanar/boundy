require 'boundy/domain'
require 'boundy/bound'
require 'boundy/bound/infinite/above' 

#require 'manacle/proxy'

module Boundy
  class Domain
    # An Anterior domain datum has a beginning, but no end -- hence, is
    # anterior-domain.
    class Anterior < Domain
      def initialize(datum)
        if datum.nil?
          raise
        end

        @from = case datum
                when Boundy::Bound
                  datum.dup
                else
                  Boundy::Bound.new(datum)
                end
        @to = Boundy::Bound::Infinite::Above.new
      end

      def cute
        "[#{@from.datum}, ∞]"
      end

      def inspect
        "#<#{self.class.name} bounded below by #{@from.inspect}>"
      end

      def to_sql_clause
        ">= '#{@from.to_sql_timestamp}'"
      end
    end
  end
end
