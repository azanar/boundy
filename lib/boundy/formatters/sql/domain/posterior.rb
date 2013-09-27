require 'boundy/formatters/sql/domain'

module Boundy::Formatters::Sql::Domain
  class Posterior
    def self.type
      Boundy::Domain::Posterior
    end

    include Boundy::Formatters::Sql::Domain

    def initialize(domain, name)
      super
      @formatter = Boundy::Formatters::Bound.new(@to)
    end

    def to_s
      "#{@name} <= '#{@formatter.to_s}'"
    end
  end
end

