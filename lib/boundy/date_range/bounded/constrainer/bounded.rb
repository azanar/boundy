require 'boundy/date_range/bounded/constrainer'

module Boundy::DateRange
  class Bounded
    module Constrainer
      class Bounded
        include Boundy::DateRange::Bounded::Constrainer

        def initialize(bounded, subject)
          @bounded = bounded
          @subject = subject
        end
      end
    end
  end
end
