class Boundy::Bound::FormatterTest < ActiveSupport::TestCase
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
      include Boundy::Bound::Formatter
    end
  end
end

