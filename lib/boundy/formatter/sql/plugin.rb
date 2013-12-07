require 'boundy'

require 'punchout'
require 'boundy/formatter/sql/factory'

module Boundy
  module Formatter
    class Sql
      module Plugin
        extend Punchout::Punchable
        class << self

          module FactoryMethods
            def factory
              @factory ||= Factory.new(self)
            end
          end

          def included(base)
            # XXX: This should really become an explicit include.
            unless base.respond_to?(:factory)
              base.instance_exec do
                extend FactoryMethods
              end
            end
            Boundy.logger.info "REGISTERING #{base} AS FORMATTER FOR #{base.type}"
            matchable = Punchout::Matcher::Ancestry.new(base.type).punches(base.factory)
            puncher.add(matchable)
          end

          def for(obj)
            punch(obj)
          end
        end
      end
    end
  end
end
