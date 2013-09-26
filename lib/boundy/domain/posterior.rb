require 'boundy/domain'
require 'boundy/bound'
require 'boundy/bound/infinite/below' 

module Boundy
  module Domain
    class Posterior 
      def self.builder
        {
          bounds: {
            from: Boundy::Bound::Infinite::Below, 
            to: Boundy::Bound
          },
          builder: Proc.new {|b,e| self.new(e)}
        }
      end

      include Domain::Plugin

      def initialize(datum)
        if datum.nil?
          raise
        end

        @from = Boundy::Bound::Infinite::Below.new
        @to = case datum
                when Boundy::Bound
                  datum
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
    end
  end
end
