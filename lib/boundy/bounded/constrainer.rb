require 'boundy/bound/constrainer'

module Boundy
  class Bounded
    class Constrainer
      def initialize(bounded, subject)
        @bounded = bounded
        @subject = subject
      end

      def constrain
        from = Boundy::Bound::Constrainer.new(@bounded.from, @subject.from)
        to = Boundy::Bound::Constrainer.new(@bounded.to, @subject.to)

        Boundy::Bounded.new(from.max, to.min)
      end
    end
  end
end
