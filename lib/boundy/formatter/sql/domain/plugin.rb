module Boundy
  module Formatter
    class Sql
      class Domain
        module Plugin
          extend Punchout::Punchable
          class << self
            def included(base)
              Boundy.logger.info "REGISTERING #{base} AS DOMAIN FORMATTER FOR #{base.type}"
              matchable = Punchout::Matcher::Ancestry.new(base.type).punches(base)
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
end
