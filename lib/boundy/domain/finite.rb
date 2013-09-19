require 'boundy/domain'

module Boundy
  module Domain
    class Finite

      def self.builder
        {
          bounds: {
            from: Boundy::Bound, 
            to: Boundy::Bound
          },
          builder: Proc.new {|b,e| self.new(b,e) }
        }
      end

      include Domain::Plugin

      def initialize(b,e)
        case b
        when Boundy::Bound
          @from = b
          @to = e
        else
          raise "I can't convert #{b.class.name} into a Boundy::Domain::Finite"
        end
        unless valid?
          raise "Backlooking ranges aren't allowed.\n\nFROM: #{@from.inspect}\nTO: #{@to.inspect}"
        end
      end

      def valid?
        raise if from.nil?
        raise if to.nil?
        raise if from.class < Boundy::Bound::Infinite
        raise if to.class < Boundy::Bound::Infinite

        from <= to
      end


      def strictly_earlier?(subject)
        @from.before?(subject)
      end

      def strictly_after?(subject)
        @to.after?(subject)
      end


      def partially_after?(subject)
        @from.after?(subject) && @to.within?(subject) 
      end

      def partially_before?(subject)
        @from.within?(subject) && @to.before?(subject) 
      end

      def partially_within?(subject)
        [:within?, :partially_before?, :partially_after?].any? do |m|
          send(m, subject)
        end
      end
    end
  end
end
