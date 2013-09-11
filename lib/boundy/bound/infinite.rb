module Boundy
  # An Anterior domain date has a beginning, but no end -- hence, is
  # anterior-domain.
  class Bound
    class Infinite
      def after?(date_range)
        false
      end

      def before?(date_range)
        false
      end

      def within?(date_range)
        true
      end

      def in_time_zone(tz)
        self
      end

      def to_midnight
        self
      end

      def date
        nil
      end

      def <=>(other)
        raise ""
      end

      def to_sql_timestamp
        raise "You shouldn't be calling me!"
      end
    end
  end
end

require 'boundy/bound/infinite/above'
require 'boundy/bound/infinite/below'
