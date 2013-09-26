require 'set'

require 'punchout'
require 'punchout/matcher/class'

module Boundy
  module Comparators
    extend Punchout::Punchable


    def self.add(type, comparator)
      matchable = Punchout::Matcher::Klass.new(type).punches(comparator)
      puncher.add(matchable)
    end

    def self.comparator(datum,subject)
      comparator = if subject.respond_to?(:comparator)
                     subject.comparator
                   else
                     puncher.punch(subject.class)
                   end

      comparator.new(datum, subject)
    rescue
      raise "I can't compare myself to a #{subject.class}: #{subject.inspect}"
    end
  end
end
