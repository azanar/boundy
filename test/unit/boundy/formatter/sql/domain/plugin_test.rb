require File.expand_path('../../../../../test_helper', __FILE__)

require 'boundy/bound'
require 'boundy/domain/anterior'
require 'boundy/formatter/sql/domain/plugin'

class Boundy::Formatter::Sql::Domain::PluginTest < Test::Unit::TestCase
  test "#punch" do
    from = mock
    Boundy::Bound.expects(:===).with(from).returns(true)
    result = Boundy::Formatter::Sql::Domain::Plugin.punch(Boundy::Domain::Anterior.new(from))
    
    assert_equal Boundy::Formatters::Sql::Domain::Anterior, result
  end
end

