require 'boundy/date_range/bounded'
require 'boundy/date_range/bounded/comparator'
require 'boundy/range/comparator'
require 'boundy/time/comparator'

module Boundy
  class Bound
    module DayAligned
      class Beginning < Bound
        def initialize(date)
          if date.nil?
            raise
          end
          @date = date.beginning_of_day
        end
      end

      class End < Bound
        def initialize(date)
          if date.nil?
            raise
          end
          @date = date.end_of_day
        end
      end
    end

    def initialize(date)
      if date.nil?
        raise "Date passed is nil!"
      end
      @date = date
    end

    @@comparators = {
      Time => Boundy::Time::Comparator,
      ::Range => Boundy::Range::Comparator,
      Boundy::DateRange::Bounded => Boundy::DateRange::Bounded::Comparator
    }

    def comparator(subject)
      if @@comparators.has_key?(subject.class)
        @@comparators[subject.class].new(@date, subject)
      else
        raise "I can't compare myself to a #{subject.class}: #{subject.inspect}"
      end
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

    def beginning_of_day
      DayAligned::Beginning.new(@date)
    end

    def end_of_day
      DayAligned::End.new(@date)
    end

    def utc
      self.class.new(@date.utc)
    end

    attr_reader :date

    include Comparable

    def <=>(other)
      case other
      when Bound::Infinite
        other <=> self
      when Bound
        date <=> other.date
      when Time
        date <=> other
      else
        raise "UGH! #{other.class}"
      end
    end

    def to_sql_timestamp
      @date.strftime("%Y-%m-%d %H:%M:%S")
    end
  end
end
