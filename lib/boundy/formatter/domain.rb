require 'boundy/formatter/bound'

module Boundy
  module Formatter
    module Domain
      def initialize(domain)
        @from = domain.from
        @to = domain.to

        if @from.finite?
          @from_formatter = Boundy::Formatter::Bound.new(@from)
        end
        if @to.finite?
          @to_formatter = Boundy::Formatter::Bound.new(@to)
        end
      end
    end
  end
end
