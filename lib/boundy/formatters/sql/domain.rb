require 'punchout'
require 'punchout/matcher/class'

require 'boundy/formatter/punchable'
require 'boundy/formatter/sql'

require 'boundy/formatters/domain'

module Boundy::Formatters::Sql
  module Domain
    def self.type
      Boundy::Domain::Plugin
    end

    include Boundy::Formatter::Sql
    include Boundy::Formatter::Punchable

    def self.included(base)
      add(base.type, base)
      base.instance_exec do
        include Boundy::Formatters::Domain
        include InstanceMethods
      end
    end

    module InstanceMethods
      def initialize(domain, name)
        @name = name
        super(domain)
      end
    end
  end
end

require 'boundy/formatters/sql/domain/anterior'
require 'boundy/formatters/sql/domain/finite'
require 'boundy/formatters/sql/domain/posterior'
