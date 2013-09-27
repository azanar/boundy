require 'boundy/formatter/sql/domain'

module Boundy::Formatter::Sql::Domain
  class Posterior
    def self.type
      Boundy::Domain::Posterior
    end

    include Boundy::Formatter::Sql::Domain

    def initialize(domain, name)
      super
      @formatter = Boundy::Formatter::Bound.new(@to)
    end

    def to_s
      "#{@name} <= '#{@formatter.to_s}'"
    end
  end
end

