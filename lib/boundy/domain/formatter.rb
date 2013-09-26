require 'boundy/bound/formatter'

module Boundy
  module Domain
    module Formatter
      def initialize(domain)
        @from = domain.from
        @to = domain.to

        if @from.finite?
          @from_formatter = Boundy::Bound::Formatter.new(@from)
        end
        if @to.finite?
          @to_formatter = Boundy::Bound::Formatter.new(@to)
        end
      end
    end
  end
end
