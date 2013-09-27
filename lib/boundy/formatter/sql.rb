require 'boundy'

require 'boundy/formatter/factory'

module Boundy
  module Formatter
    module Sql
      include Boundy::Formatter::Factory

      class << self
        def included(base)
          add(base.type, base)
        end

        def new(subject, name)
          f = formatter(subject)
          if f.nil?
            raise "I have no formatter for #{subject.class}"
          end
          f.new(subject, name)
        end

        def add(type, formatter)
          matchable = Punchout::Matcher::Ancestry.new(type).punches(formatter)
          puncher.add(matchable)
        end

        def formatter(klass)
          puncher.punch(klass)
        end
      end
    end
  end
end

require 'boundy/formatters/sql/domain'
