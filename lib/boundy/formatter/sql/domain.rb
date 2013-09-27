require 'punchout'
require 'punchout/matcher/class'

require 'boundy/formatter/domain'
require 'boundy/formatter/sql'

module Boundy::Formatter::Sql
  module Domain
    extend Punchout::Punchable

    def self.type
      Boundy::Domain::Plugin
    end

    include Boundy::Formatter::Sql

    class << self
      def included(base)
        add(base.type, base)
        base.instance_exec do
          include Boundy::Formatter::Domain
          include InstanceMethods
        end
      end

      def new(subject, name)
        f = formatter(subject)
        if f.nil?
          raise "I have no formatter for #{subject.class}"
        end
        f.new(subject, name)
      end

      def add(type, comparator)
        matchable = Punchout::Matcher::Klass.new(type).punches(comparator)
        puncher.add(matchable)
      end

      def formatter(klass)
        puncher.punch(klass)
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

require 'boundy/formatter/sql/domain/anterior'
require 'boundy/formatter/sql/domain/finite'
require 'boundy/formatter/sql/domain/posterior'
