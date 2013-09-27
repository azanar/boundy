require 'punchout/matcher/class'

module Boundy
  module Formatter
    module Punchable
      def self.included(base)
        base.instance_exec do
          extend Punchout::Punchable
          extend ClassMethods
        end
      end

      module ClassMethods

        def new(subject, name)
          f = formatter(subject)
          if f.nil?
            raise "I have no formatter for #{subject.class}"
          end
          f.new(subject, name)
        end

        def add(type, comparator)
          matchable = Punchout::Matcher::Klass.new(type).punches(comparator)
          puncher.add(matchable)
        end

        def formatter(klass)
          puncher.punch(klass)
        end
      end
    end
  end
end
