require 'boundy/bounded'
require 'boundy/bounded/constrainer'

module Boundy
  class Range
    class Constrainer
      def initialize(bounded, range)
        @bounded = bounded
        subject = Boundy::Bounded.new(range.begin, range.end)
        @constrainer = Boundy::Bounded::Constrainer.new(@bounded, subject)
      end

      def constrain
        @constrainer.constrain
      end
    end
  end
end
