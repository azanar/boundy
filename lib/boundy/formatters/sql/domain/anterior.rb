require 'boundy/formatters/sql/domain'

module Boundy::Formatters::Sql::Domain
  class Anterior
    def self.type
      Boundy::Domain::Anterior
    end

    include Boundy::Formatters::Sql::Domain

    def initialize(domain, name)
      super
      @formatter = Boundy::Formatters::Bound.new(@from)
    end

    def to_s
      "#{@name} >= '#{@formatter.to_s}'"
    end
  end
end

