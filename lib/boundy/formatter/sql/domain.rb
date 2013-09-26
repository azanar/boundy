require 'boundy/formatter/domain'
require 'boundy/formatter/sql'

module Boundy
  module Formatter
    module Domain
      class Sql
        def self.type
          Boundy::Domain::Plugin
        end

        include Boundy::Formatter::Sql
        include Boundy::Domain::Formatter

        def to_s
          statements = []
          if @to_formatter
            statements << "<= '#{@to_formatter.to_s}'"
          end
          if 
            statements << ">= '#{@from_formatter.to_s}'"
          end
          statements.join(" AND ")
        end
      end
    end
  end
end

