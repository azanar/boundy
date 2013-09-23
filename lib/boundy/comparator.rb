require 'boundy/comparators'

module Boundy
  module Comparator
    def self.included(base)
      types = if base.respond_to?(:type)
                [base.type]
              elsif base.respond_to?(:types)
                base.types
              else
                []
              end

      types.each do |t|
        Boundy::Comparators.add(t, base)
      end
    end
  end
end
