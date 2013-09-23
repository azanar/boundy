require 'set'

require 'punchout'
require 'punchout/matcher/class'

module Boundy
  module Comparators
    extend Punchout::Punchable

    self.matcher = Punchout::Matcher::Klass

    def self.add(type, comparator)
      puncher.add(type, comparator)
    end

    def self.comparator(datum,subject)
      comparator = if subject.respond_to?(:comparator)
                     subject.comparator
                   else
                     puncher.fetch(subject.class)
                   end

      comparator.new(datum, subject)
    rescue
      raise "I can't compare myself to a #{subject.class}: #{subject.inspect}"
    end
  end
end
