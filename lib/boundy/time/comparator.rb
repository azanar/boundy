require 'boundy/comparator'

module Boundy
  class Time
    class Comparator
      def self.types
        [::Time, ActiveSupport::TimeWithZone]
      end

      include Boundy::Comparator

      def initialize(bound, time)
        if bound.nil?
          raise
        end

        if time.nil?
          raise
        end
        other = Boundy::Bound.new(time)
        @comparator = Boundy::Bound::Comparator.new(bound, other) 
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
