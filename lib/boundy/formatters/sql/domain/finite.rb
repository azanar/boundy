require 'boundy/formatters/sql/domain'

module Boundy::Formatters::Sql::Domain
  class Finite
    def self.type
      Boundy::Domain::Finite
    end

    include Boundy::Formatters::Sql::Domain
    def initialize(domain, name)
      super
      @from_formatter = Boundy::Formatters::Bound.new(@from)
      @to_formatter = Boundy::Formatters::Bound.new(@to)
    end

    def to_s
      "#{@name} >= '#{@from_formatter.to_s}' AND #{@name} <= '#{@to_formatter.to_s}'"
    end
  end
end
