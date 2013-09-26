require 'punchout/matcher/ancestry'

module Boundy
  module Formatter
    module Sql
      extend Punchout::Punchable


      class << self
        def included(base)
          add(base.type, base)
        end

        def new(subject)
          f = formatter(subject)
          if f.nil?
            raise "I have no formatter for #{subject.inspect}"
          end
          f.new(subject)
        end

        def add(type, comparator)
          matchable = Punchout::Matcher::Ancestry.new(type).punches(comparator)
          puncher.add(matchable)
        end

        def formatter(klass)
          puncher.punch(klass)
        end
      end
    end
  end
end
