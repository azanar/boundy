require 'boundy/bound'
require 'boundy/bound/infinite'
require 'boundy/comparators'

#require 'manacle/proxy'

module Boundy
  class Bound
    def initialize(datum)
      if datum.class <= self.class || datum.class < Boundy::Bound::Infinite
        raise "Datum is a Bound already!"
      end

      if datum.nil?
        raise "Datum passed is nil!"
      end
      @datum = datum
    end

    def after?(subject)
      Comparators.comparator(self, subject).after?
    end

    def before?(subject)
      Comparators.comparator(self, subject).before?
    end

    def within?(subject)
      Comparators.comparator(self, subject).within?
    end

    def finite?
      true
    end

    def infinite?
      false
    end

    def inspect
      "#<#{self.class.name} bounded at #{@datum.inspect}>"
    end

    def comparator
      Boundy::Bound::Comparator
    end

    attr_reader :datum

    include Comparable

    def <=>(other)
      case other
      when Boundy::Bound::Infinite::Above
        (other <=> self) * -1
      when Boundy::Bound::Infinite::Below
        (other <=> self) * -1
      when Boundy::Bound
        datum <=> other.datum
      else
        raise "Can not compare a Bound to a #{other.class}"
      end
    end
  end
end
