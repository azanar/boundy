require 'active_support/time'

require 'boundy/date_range/bounded/anterior'
require 'boundy/date_range/bounded/posterior'

module DateRange
  class Bounded
    class MidnightAligned < DateRange::Bounded
      def bound_class
        Bound::MidnightAligned
      end
    end

    def initialize(b,e=nil)
      case b
      when Bound
        @from = b
        @to = e
      when Range
        @from = bound_class.new(b.begin)
        @to = bound_class.new(b.end)
      when Time
        @from = bound_class.new(b)
        @to = bound_class.new(e)
      else
        raise "Why the hell is b a #{b.class.name}"
      end

      unless valid?
        raise "Backlooking date ranges aren't allowed."
      end
    end

    def bound_class
      Bound
    end

    def utc
      self.class.new(from.utc, to.utc)
    end

    def in_time_zone(tz)
      self.class.new(from.in_time_zone(tz), to.in_time_zone(tz))
    end

    def to_midnight
      MidnightAligned.new(from, to)
    end

    attr_reader :from
    attr_reader :to

    def joinable?(subject)
      strictly_earlier?(subject) || strictly_later?(subject)
    end

    def valid?
      from.date < to.date
    end

    def constrain_to(range)
      
    end

    def to_sql_clause
      "BETWEEN #{from.to_sql_timestamp} AND #{to.to_sql_timestamp}"
    end

    def strictly_earlier?(subject)
      @from.before?(subject)
    end

    def strictly_after?(subject)
      @to.after?(subject)
    end

    def within?(subject)
      @from.within?(subject) || @from.after?(subject) and
      @to.within?(subject) || @to.before?(subject)
    end

    alias :in_range? :within?

    def partially_after?(subject)
      @from.after?(subject) && @to.within?(subject) 
    end

    def partially_before?(subject)
      @from.within?(subject) && @to.before?(subject) 
    end

    def partially_within?(subject)
      [:within?, :partially_before?, :partially_after?].any? do |m|
        send(m, subject)
      end
    end
  end
end
