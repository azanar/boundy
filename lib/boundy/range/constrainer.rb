require 'boundy/domain'
require 'boundy/domain/constrainer'

module Boundy
  class Range
    class Constrainer
      def initialize(domain, range)
        other = Boundy::Domain.new(range.begin, range.end)
        @constrainer = Boundy::Domain::Constrainer.new(domain, other)
      end

      def constrain
        @constrainer.constrain
      end
    end
  end
end
