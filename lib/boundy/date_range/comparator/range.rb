module DateRange
  module Comparator
    class Range
      def initialize(date, subject)
        @date = date
        @subject = subject
      end

      def after?
        @subject.begin > @date && @subject.end >= @date
      end

      def before?
        @subject.begin <= @date && @subject.end < @date
      end

      def within?
        @subject.begin <= @date && @subject.end >= @date
      end
    end
  end
end

