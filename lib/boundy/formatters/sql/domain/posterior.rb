require 'boundy/formatter/sql/domain/plugin'
require 'boundy/domain/posterior'

module Boundy::Formatters::Sql
  class Domain
    class Posterior
      def self.type
        Boundy::Domain::Posterior
      end

      include Boundy::Formatter::Sql::Domain::Plugin

      def initialize(domain, name)
        @name = name
        @formatter = Boundy::Formatter::Sql.new(domain.to, name)
      end

      def to_s
        "#{@name} <= '#{@formatter.to_s}'"
      end
    end
  end
end
