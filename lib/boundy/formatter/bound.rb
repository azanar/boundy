require 'punchout'
require 'punchout/matcher/ancestry'

module Boundy
  module Formatter
     module Bound
      extend Punchout::Punchable

      class << self
        def included(base)
          base.instance_eval do
            include InstanceMethods
          end

          add(base.type, base.factory.new("%Y-%m-%d %H:%M:%S"))
        end

        def new(bound)
          d = bound.datum
          f = formatter(d)
          if f.nil?
            raise "I have no formatter for #{d.class}: #{d.class.ancestors}"
          end
          f.build(d)
        end


        def add(type, comparator)
          matchable = Punchout::Matcher::Ancestry.new(type).punches(comparator)
          puncher.add(matchable)
        end

        def formatter(klass)
          puncher.punch(klass)
        end
      end

      module InstanceMethods
        def to_s
          @formatter.to_s
        end
      end
    end
  end
end
