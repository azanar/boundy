require 'boundy/bound/constrainer'
require 'boundy/domain'

module Boundy
  module Domain
    class Constrainer
      def initialize(me, other)
        @me = me
        @other = other
      end


      def constrain
        from = Boundy::Bound::Constrainer.new(@me.from, @other.from)
        to = Boundy::Bound::Constrainer.new(@me.to, @other.to)

        Boundy::Domain.new(from.max, to.min)
      end
    end
  end
end
