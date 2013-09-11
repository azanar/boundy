require 'boundy/bound/constrainer'

module Boundy
  class Domain
    class Constrainer
      def initialize(domain, subject)
        @domain = domain
        @subject = subject
      end

      def constrain
        from = Boundy::Bound::Constrainer.new(@domain.from, @subject.from)
        to = Boundy::Bound::Constrainer.new(@domain.to, @subject.to)

        Boundy::Domain.new(from.max, to.min)
      end
    end
  end
end
