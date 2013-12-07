require File.expand_path('../../../../../test_helper', __FILE__)

require 'boundy/formatters/sql/domain/anterior'

class Boundy::Formatters::Sql::Domain::AnterorTest < Test::Unit::TestCase
  setup do

    @name = "mock_thing"

    @mock_domain = mock

    @mock_from = mock

    @mock_domain.expects(:from).returns(@mock_from)

    @mock_from_formatter = mock

    Boundy::Formatter::Sql.expects(:new).with(@mock_from, @name).returns(@mock_from_formatter)
  end

  test "#to_s" do
    @mock_from_formatter.expects(:to_s).returns("from")

    formatter = Boundy::Formatters::Sql::Domain::Anterior.new(@mock_domain, @name)
    result = formatter.to_s
    
    assert_equal "mock_thing >= 'from'", result
  end
end
