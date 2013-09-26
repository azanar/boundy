require File.expand_path('../../../test_helper', __FILE__)

require 'boundy/formatter/bound'

class Boundy::Formatter::BoundTest < ActiveSupport::TestCase
  test "#to_s" do 
    mock_type = Class.new
    mock_factory = mock

    formatter_klass = Class.new do
      def self.type=(type)
        @type = type
      end

      def self.type
        @type
      end

      def self.factory=(factory)
        @factory = factory
      end
      
      def self.factory
        @factory
      end
    end

    formatter_klass.type = mock_type
    formatter_klass.factory = mock_factory

    formatter_klass.class_eval do
      include Boundy::Formatter::Bound
    end
  end
end

