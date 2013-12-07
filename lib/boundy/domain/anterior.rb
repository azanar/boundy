require 'boundy/domain'
require 'boundy/bound'
require 'boundy/bound/infinite/above' 

module Boundy
  module Domain
    # An Anterior domain datum has a beginning, but no end -- hence, is
    # anterior-domain.
    class Anterior 
      def self.builder
        {
          bounds: {
            from: Boundy::Bound, 
            to: Boundy::Bound::Infinite::Above
          },
          builder: Proc.new {|b,e| self.new(b) }
        }
      end

      include Domain::Plugin

      def initialize(datum)
        if datum.nil?
          raise
        end

        @from = case datum
                when Boundy::Bound
                  datum
                else
                  Boundy::Bound.new(datum)
                end
        @to = Boundy::Bound::Infinite::Above.new
      end

      def cute
        "[#{@from.datum}, infinity]"
      end

      def inspect
        "#<#{self.class.name} bounded below by #{@from.inspect}>"
      end
    end
  end
end
