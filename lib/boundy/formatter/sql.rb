require 'boundy'

require 'punchout/matcher/ancestry'

module Boundy
  module Formatter
    module Sql
      extend Punchout::Punchable

      class << self
        def included(base)
          puts "INCLUDED!"
          add(base.type, base)
        end

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

require 'boundy/formatter/sql/domain'
