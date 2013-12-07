require File.expand_path('../../../test_helper', __FILE__)

require 'boundy/formatter/sql'

class Boundy::Formatter::SqlTest < Test::Unit::TestCase
  setup do
    mock_instance = mock
    @mock_delegate_formatter_factory = mock

    Boundy::Formatter::Sql::Plugin.expects(:for).with(mock_instance).returns(@mock_delegate_formatter_factory)
    @mock_formatter = mock
    @mock_delegate_formatter_factory.expects(:build).with(mock_instance, "mock_name").returns(@mock_formatter)

    @formatter = Boundy::Formatter::Sql.new(mock_instance, "mock_name")
  end

  test ".to_s" do
    mock_rep = mock

    @mock_formatter.expects(:to_s).returns(mock_rep)

    result = @formatter.to_s

    assert_equal mock_rep, result
  end
end
