require 'boundy/formatter/sql/domain'

module Boundy::Formatter::Sql::Domain
  class Anterior
    def self.type
      Boundy::Domain::Anterior
    end

    include Boundy::Formatter::Sql::Domain

    def initialize(domain, name)
      super
      @formatter = Boundy::Formatter::Bound.new(@from)
    end

    def to_s
      "#{@name} >= '#{@formatter.to_s}'"
    end
  end
end

