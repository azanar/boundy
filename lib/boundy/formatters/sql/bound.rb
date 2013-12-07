require 'boundy/bound'

require 'boundy/formatter/sql/plugin'

require 'boundy/formatters/bound'

module Boundy::Formatters::Sql
  class Bound
    def self.type
      Boundy::Bound
    end

    include Boundy::Formatters::Bound
    include Boundy::Formatter::Sql::Plugin

    def initialize(bound, name)
      @formatter = Boundy::Formatter::Sql.new(bound.datum, name)
      super(bound)
    end
  end
end

