require 'boundy/formatters/bound'

module Boundy
  module Formatters
    module Domain
      def initialize(domain)
        @from = domain.from
        @to = domain.to
      end
    end
  end
end
