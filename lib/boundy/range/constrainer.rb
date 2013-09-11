require 'boundy/domain'
require 'boundy/domain/constrainer'

module Boundy
  class Range
    class Constrainer
      def initialize(domain, range)
        @domain = domain
        subject = Boundy::Domain.new(range.begin, range.end)
        @constrainer = Boundy::Domain::Constrainer.new(@domain, subject)
      end

      def constrain
        @constrainer.constrain
      end
    end
  end
end
