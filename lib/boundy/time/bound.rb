module Boundy
  class Time
    class Bound < Boundy::Bound
      def beginning_of_day
        DayAligned::Beginning.new(@datum)
      end

      def end_of_day
        DayAligned::End.new(@datum)
      end
      def in_time_zone(tz)
        self.class.new(@datum.in_time_zone(tz))
      end

      def utc
        self.class.new(@datum.utc)
      end
    end
  end
end
