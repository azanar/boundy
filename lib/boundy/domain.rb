require 'boundy/bound'

require 'boundy/domain/comparator'
require 'boundy/domain/constrainer'
require 'boundy/range/constrainer'

module Boundy
  module Domain
    module Plugin
      def self.included(base)
        Domain.builder.add(base)
        base.instance_eval do
          include InstanceMethods
          attr_reader :from
          attr_reader :to
        end
      end
    end

    class Builder
      def initialize
        @klasses = {}
      end

      def add(domain_klass)
        builder = domain_klass.builder

        bound_types = builder[:bounds]
        builder_method = builder[:builder]

        @klasses[bound_types] = builder_method
      end

      def build(a,b)
        builder = @klasses[{from: a.class, to: b.class}]

        if builder.nil?
          raise "Could not find class for #{a.class} and #{b.class}"
        end

        builder.call(a,b)
      end
    end


    def self.builder
      @builder ||= Builder.new
    end


    def self.translate(bound)
      if bound.class <= Boundy::Bound or bound.class < Boundy::Bound::Infinite
        bound
      else
        Boundy::Bound.new(bound)
      end
    end

    def self.new(b,e=nil)
      if b.class <= Boundy::Domain::Plugin 
        b
      else
        b = translate(b)
        e = translate(e)

        built = builder.build(b,e)
        unless built.class < Plugin
          raise
        end
        built
      end
    end

    module InstanceMethods

      def within?(subject)
        @from.within?(subject) || @from.after?(subject) and
        @to.within?(subject) || @to.before?(subject)
      end

      def joinable?(subject)
        strictly_earlier?(subject) || strictly_later?(subject)
      end

      def constrain_to(subject)
        constrainer(subject).constrain
      end

      def constrainer(subject)
        if subject.class == ::Range
          Boundy::Range::Constrainer.new(self, subject)
        elsif subject.class < Boundy::Domain::Plugin
          Boundy::Domain::Constrainer.new(self, subject)
        else
          raise "I can't constrain myself against a #{subject.class}"
        end
      end

      def comparator
        Boundy::Domain::Comparator
      end

      def format(formatter)
        if from.finite?
        elsif to.finite?
        end
      end
    end
  end
end


require 'boundy/domain/anterior'
require 'boundy/domain/finite'
require 'boundy/domain/posterior'
