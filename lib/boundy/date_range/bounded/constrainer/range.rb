require 'boundy/date_range/bounded/constrainer'

module Boundy::DateRange
  class Bounded
    module Constrainer
      class Range
        include Boundy::DateRange::Bounded::Constrainer

        def initialize(bounded, range)
          @bounded = bounded
          @subject = Boundy::DateRange::Bounded.new(range.begin, range.end)
        end
      end
    end
  end
end

