require 'set'

module Boundy
  module Comparators
    class Registry
      def initialize
        @known_types = Set.new
        @mappings = {}
      end

      def add(type, comparator)
        @known_types << type
        @mappings[type] = comparator
      end

      def fetch(type)
        @mappings.fetch(type)
      end
    end

    def self.registry
      @registry ||= Registry.new
    end

    def self.comparator(datum,subject)
      comparator = if subject.respond_to?(:comparator)
                     subject.comparator
                   else
                     registry.fetch(subject.class)
                   end

      comparator.new(datum, subject)
    rescue
      raise "I can't compare myself to a #{subject.class}: #{subject.inspect}"
    end
  end
end
