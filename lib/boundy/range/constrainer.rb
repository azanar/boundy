require 'boundy/date_range/bounded'
require 'boundy/date_range/bounded/constrainer'

module Boundy
  class Range
    class Constrainer
      def initialize(bounded, range)
        @bounded = bounded
        subject = Boundy::DateRange::Bounded.new(range.begin, range.end)
        @constrainer = Boundy::DateRange::Bounded::Constrainer.new(@bounded, subject)
      end

      def constrain
        @constrainer.constrain
      end
    end
  end
end
