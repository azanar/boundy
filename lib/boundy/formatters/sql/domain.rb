require 'boundy/formatter/sql/domain/plugin'

require 'boundy/formatters/domain'

module Boundy::Formatters::Sql
  class Domain
    def self.type
      Boundy::Domain::Plugin
    end

    def initialize(domain, name)
      @formatter = Boundy::Formatter::Sql::Domain::Plugin.for(domain).new(domain,name)
      if @formatter.nil?
        raise "No formatter registered for #{obj.inspect}"
      end
    end

    include Boundy::Formatter::Sql::Plugin

    def to_s
      @formatter.to_s
    end
  end
end

require 'boundy/formatters/sql/domain/anterior'
require 'boundy/formatters/sql/domain/finite'
require 'boundy/formatters/sql/domain/posterior'
