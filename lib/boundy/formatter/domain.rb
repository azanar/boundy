require 'boundy/formatter/bound'

module Boundy
  module Formatter
    module Domain
      def initialize(domain)
        @from = domain.from
        @to = domain.to
      end
    end
  end
end
