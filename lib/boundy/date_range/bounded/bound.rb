module DateRange
  class Bounded
    class Bound
      class MidnightAligned < Bound
        def initialize(date)
          if date.nil?
            raise
          end
          @date = date.beginning_of_day
        end
      end

      def initialize(date)
        if date.nil?
          raise
        end
        @date = date
      end

      def constrainer(subject)
        case subject
        when Range
           DateRange::Constrainer::Range.new(@date, subject)
        when DateRange::Bounded
           DateRange::Constrainer::Bounded.new(@date, subject)
        else
          raise "What the fuck kind of subject is #{subject.class}"
        end
      end

      def comparator(subject)
        case subject
        when Time
           DateRange::Comparator::Time.new(@date, subject)
        when Range
           DateRange::Comparator::Range.new(@date, subject)
        else
          raise "What the fuck kind of subject is #{subject.class}"
        end
      end

      def constrain_to(subject)
        constrainer(subject).constrain
      end

      def after?(subject)
        comparator(subject).after?
      end

      def before?(subject)
        comparator(subject).before?
      end

      def within?(subject)
        comparator(subject).within?
      end

      def in_time_zone(tz)
        self.class.new(@date.in_time_zone(tz))
      end

      def to_midnight
        self.const_get(:MidnightAligned).new(@date)
      end

      def utc
        self.class.new(@date.utc)
      end

      attr_reader :date

      def to_sql_timestamp
        @date.strftime("%Y-%m-%d %H:%M:%S")
      end
    end
  end
end

