require File.expand_path('../../../test_helper', __FILE__)

require 'boundy/formatter/sql'

class Boundy::Formatter::SqlTest < ActiveSupport::TestCase
  setup do
    @random = Class.new

    @formatter = Class.new do
      def self.type=(type)
        @@type = type
      end

      def self.type
        @@type
      end

      def initialize(inst)
      end
    end

    @formatter.type = @random

    @formatter.class_eval do
      include Boundy::Formatter::Sql
    end
  end

  test "#new" do
    rand_inst = @random.new

    Boundy::Formatter::Sql.new(rand_inst)

  end
end
