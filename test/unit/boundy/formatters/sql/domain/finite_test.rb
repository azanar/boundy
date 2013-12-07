require File.expand_path('../../../../../test_helper', __FILE__)

require 'boundy/formatters/sql/domain/finite'

class Boundy::Formatters::Sql::Domain::FiniteTest < Test::Unit::TestCase
  setup do
    @name = "mock_thing"

    @mock_domain = mock

    @mock_from = mock
    @mock_to = mock

    @mock_domain.expects(:from).returns(@mock_from)
    @mock_domain.expects(:to).returns(@mock_to)

    @mock_from_formatter = mock
    @mock_to_formatter = mock

    Boundy::Formatter::Sql.expects(:new).with(@mock_from, @name).returns(@mock_from_formatter)
    Boundy::Formatter::Sql.expects(:new).with(@mock_to, @name).returns(@mock_to_formatter)

  end

  test "#to_s" do
    @mock_from_formatter.expects(:to_s).returns("from")
    @mock_to_formatter.expects(:to_s).returns("to")

    formatter = Boundy::Formatters::Sql::Domain::Finite.new(@mock_domain, "mock_thing")
    result = formatter.to_s
    
    assert_equal "mock_thing >= 'from' AND mock_thing <= 'to'", result
  end
end

