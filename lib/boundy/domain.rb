require 'active_support/time'

require 'boundy/bound'
require 'boundy/bound/infinite'

require 'boundy/domain/anterior'
require 'boundy/domain/posterior'

require 'boundy/domain/constrainer'
require 'boundy/range/constrainer'

module Boundy
  class Domain
    def initialize(b,e=nil)
      case b
      when Boundy::Bound
        @from = b
        @to = e
      when Boundy::Bound::Infinite::Below
        @from = b
        @to = e
      when ::Time
        @from = beginning_bound_class.new(b)
        @to = ending_bound_class.new(e)
      when Range
        @from = beginning_bound_class.new(b.begin)
        @to = ending_bound_class.new(b.end)
      else
        raise "Why the hell is b a #{b.class.name}"
      end

      unless valid?
        raise "Backlooking date ranges aren't allowed.\n\nFROM: #{@from.inspect}\nTO: #{@to.inspect}"
      end
    end

    def bound_class
      Boundy::Bound
    end

    alias :beginning_bound_class :bound_class
    alias :ending_bound_class :bound_class

    attr_reader :from
    attr_reader :to

    def joinable?(subject)
      strictly_earlier?(subject) || strictly_later?(subject)
    end

    def valid?
      raise if from.nil?
      raise if to.nil?

      from <= to
    end

    def constrain_to(subject)
      constrainer(subject).constrain
    end

    def constrainer(subject)
      case subject
      when ::Range
         Boundy::Range::Constrainer.new(self, subject)
      when Boundy::Domain
         Boundy::Domain::Constrainer.new(self, subject)
      else
        raise "I can't constrain myself against a #{subject.inspect}"
      end
    end

    def to_sql_clause
      "BETWEEN '#{@from.to_sql_timestamp}' AND '#{@to.to_sql_timestamp}'"
    end

    def strictly_earlier?(subject)
      @from.before?(subject)
    end

    def strictly_after?(subject)
      @to.after?(subject)
    end

    def within?(subject)
      puts "within? #{subject.inspect}"
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
