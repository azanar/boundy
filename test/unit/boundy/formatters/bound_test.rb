require File.expand_path('../../../test_helper', __FILE__)

require 'boundy/formatters/bound'

class Boundy::Formatters::BoundTest < Test::Unit::TestCase
  test "#to_s" do 
    mock_type = Class.new

    formatter_klass = Class.new do
      def initialize(bound)
        @formatter = self.class.formatter
        super
      end

      def self.formatter=(formatter)
        @formatter = formatter
      end

      def self.formatter
        @formatter
      end
    end

    formatter_klass.class_eval do
      include Boundy::Formatters::Bound
    end

    mock_bound = mock
    mock_formatter = mock

    formatter_klass.formatter = mock_formatter

    mock_formatted = mock
    mock_formatter.expects(:to_s).returns(mock_formatted)

    formatter = formatter_klass.new(mock_bound)

    result = formatter.to_s

    assert_equal mock_formatted, result
  end
end

