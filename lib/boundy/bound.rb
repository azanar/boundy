require 'boundy/bounded'
require 'boundy/bounded/anterior'
require 'boundy/bounded/posterior'
require 'boundy/bounded/comparator'
require 'boundy/range/comparator'
require 'boundy/time/comparator'

module Boundy
  class Bound
    def initialize(datum)
      if datum.nil?
        raise "Datum passed is nil!"
      end
      @datum = datum
    end

    @@comparators = {
      ::Time => Boundy::Time::Comparator,
      ::Range => Boundy::Range::Comparator,
      Boundy::Bounded::Anterior => Boundy::DateRange::Bounded::Comparator,
      Boundy::Bounded::Posterior => Boundy::DateRange::Bounded::Comparator,
      Boundy::Bounded::Anterior::MidnightAligned => Boundy::DateRange::Bounded::Comparator,
      Boundy::Bounded::Posterior::MidnightAligned => Boundy::DateRange::Bounded::Comparator,
      Boundy::Bounded => Boundy::DateRange::Bounded::Comparator
    }

    def comparator(subject)
      if @@comparators.has_key?(subject.class)
        @@comparators[subject.class].new(@datum, subject)
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


    attr_reader :datum

    include Comparable

    def <=>(other)
      case other
      when Boundy::Bound::Infinite
        other <=> self
      when Boundy::Bound
        datum <=> other.datum
      when ::Time
        datum <=> other
      else
        raise "UGH! #{other.class}"
      end
    end

    def to_sql_timestamp
      @datum.strftime("%Y-%m-%d %H:%M:%S")
    end
  end
end
