module Boundy::DateRange
  module Comparator
    class Time
      def initialize(date, subject)
        @date = date
        @subject = subject
      end

      def after?
        @date < @subject
      end

      def before?
        @date > @subject
      end

      def within?
        @date == @subject
      end
    end
  end
end
