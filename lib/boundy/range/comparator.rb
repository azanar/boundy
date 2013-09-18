require 'boundy/comparator'

module Boundy
  class Range
    class Comparator
      def self.type
        ::Range
      end

      include Boundy::Comparator

      def initialize(domain, range)
        if domain.nil?
          raise
        end

        if range.nil?
          raise
        end

        other = Boundy::Domain.new(range.begin, range.end)
        @comparator = Boundy::Domain::Comparator.new(domain, other) 
      end

      def after?
        @comparator.after?
      end

      def before?
        @comparator.before?
      end

      def within?
        @comparator.within?
      end
    end
  end
end
