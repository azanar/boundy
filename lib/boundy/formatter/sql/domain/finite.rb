require 'boundy/formatter/sql/domain'

module Boundy::Formatter::Sql::Domain
  class Finite
    def self.type
      Boundy::Domain::Finite
    end

    include Boundy::Formatter::Sql::Domain
    def initialize(domain, name)
      super
      @from_formatter = Boundy::Formatter::Bound.new(@from)
      @to_formatter = Boundy::Formatter::Bound.new(@to)
    end

    def to_s
      "#{@name} >= '#{@from_formatter.to_s}' AND #{@name} <= '#{@to_formatter.to_s}'"
    end
  end
end
