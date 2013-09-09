require 'boundy/date_range/bounded/bound/constrainer'

module Boundy
  module DateRange
    class Bounded
      module Constrainer
        def constrain
          from = Boundy::DateRange::Bounded::Bound::Constrainer.new(@bounded.from, @subject.from)
          to = Boundy::DateRange::Bounded::Bound::Constrainer.new(@bounded.to, @subject.to)

          Boundy::DateRange::Bounded.new(from.max, to.min)
        end
      end
    end
  end
end
