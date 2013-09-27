require 'punchout/matcher/class'

module Boundy
  module Formatter
    module Factory
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
            Boundy.logger.info "PUNCHER #{puncher.inspect}"
            raise "I have no formatter for #{subject.class}"
          end
          f.new(subject, name)
        end

        def add(type, formatter)
          matchable = Punchout::Matcher::Ancestry.new(type).punches(formatter)
          Boundy.logger.info "Adding #{type} as punchable to #{formatter}"
          puncher.add(matchable)
        end

        def formatter(klass)
          puncher.punch(klass)
        end
      end
    end
  end
end

