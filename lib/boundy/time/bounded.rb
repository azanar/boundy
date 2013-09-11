module Boundy
  class Time
    class Range

      def utc
        self.class.new(from.utc, to.utc)
      end

      def in_time_zone(tz)
        self.class.new(from.in_time_zone(tz), to.in_time_zone(tz))
      end

      def to_midnight
        DayAligned.new(from, to)
      end

    end
  end
end
