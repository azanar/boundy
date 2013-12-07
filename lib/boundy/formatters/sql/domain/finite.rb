require 'boundy/formatter/sql/domain/plugin'
require 'boundy/domain/finite'

module Boundy::Formatters::Sql
  class Domain
    class Finite
      def self.type
        Boundy::Domain::Finite
      end

      include Boundy::Formatter::Sql::Domain::Plugin

      def initialize(domain, name)
        @name = name
        @from_formatter = Boundy::Formatter::Sql.new(domain.from, name)
        @to_formatter = Boundy::Formatter::Sql.new(domain.to, name)
      end

      def to_s
        "#{@name} >= '#{@from_formatter.to_s}' AND #{@name} <= '#{@to_formatter.to_s}'"
      end
    end
  end
end
