require 'boundy/domain'
require 'boundy/bound'
require 'boundy/bound/infinite/below' 

#require 'manacle/proxy'

module Boundy
  class Domain
    class Posterior < Domain
      def initialize(datum)
        if datum.nil?
          raise
        end

        @from = Boundy::Bound::Infinite::Below.new
        @to = case datum
                when Boundy::Bound
                  datum.dup
                else
                  Boundy::Bound.new(datum)
                end
      end

      def cute
        "[-∞, #{@to.datum}]"
      end

      def inspect
        "#<#{self.class.name} bounded above by #{@to.inspect}>"
      end

      def to_sql_clause
        "<= '#{@to.to_sql_timestamp}'"
      end
    end
  end
end
