require File.expand_path('../../../../test_helper', __FILE__)

require 'boundy/formatter/sql/plugin'

class Boundy::Formatter::Sql::PluginTest < Test::Unit::TestCase
  setup do
    @random = Class.new do
      def inspect
        "RANDOM"
      end
    end

    @formatter = Class.new do
      def self.type=(type)
        @@type = type
      end

      def self.type
        @@type
      end

      def inspect
        "FORMATTTER"
      end

      def initialize(inst, name)
      end
    end

    @formatter.type = @random

    @mock_factory = mock
    Boundy::Formatter::Sql::Factory.expects(:new).returns(@mock_factory)
    Boundy::Formatter::Sql::Factory.expects(:new).never

    @formatter.class_eval do
      include Boundy::Formatter::Sql::Plugin
    end
  end

  test "#for" do
    rand_inst = @random.new


    result = Boundy::Formatter::Sql::Plugin.for(rand_inst)
    assert_equal @mock_factory, result

  end
end

