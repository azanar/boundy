require 'boundy/formatter/sql/domain/plugin'
require 'boundy/domain/anterior'

module Boundy::Formatters::Sql
  class Domain
    class Anterior
      def self.type
        Boundy::Domain::Anterior
      end

      include Boundy::Formatter::Sql::Domain::Plugin

      def initialize(domain, name)
        @name = name
        @formatter = Boundy::Formatter::Sql.new(domain.from, name)
      end

      def to_s
        "#{@name} >= '#{@formatter.to_s}'"
      end
    end
  end
end
