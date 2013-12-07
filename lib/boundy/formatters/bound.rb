require 'punchout'
require 'punchout/matcher/ancestry'

module Boundy
  module Formatters
    module Bound
      def initialize(bound)
        @bound = bound
      end

      def to_s
        @formatter.to_s
      end
    end
  end
end
