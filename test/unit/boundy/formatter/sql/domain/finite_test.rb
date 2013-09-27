require File.expand_path('../../../../../test_helper', __FILE__)

require 'boundy/formatter/sql/domain/finite'

class Boundy::Formatter::Sql::Domain::FiniteTest < ActiveSupport::TestCase
  setup do

    @mock_domain = mock

    @mock_from = mock
    @mock_to = mock

    @mock_domain.expects(:from).returns(@mock_from)
    @mock_domain.expects(:to).returns(@mock_to)

    @mock_from_formatter = mock
    @mock_to_formatter = mock

    Boundy::Formatter::Bound.expects(:new).with(@mock_from).returns(@mock_from_formatter)
    Boundy::Formatter::Bound.expects(:new).with(@mock_to).returns(@mock_to_formatter)

  end

  test "#to_s" do
    @mock_from_formatter.expects(:to_s).returns("from")
    @mock_to_formatter.expects(:to_s).returns("to")

    formatter = Boundy::Formatter::Sql::Domain::Finite.new(@mock_domain, "mock_thing")
    result = formatter.to_s
    
    assert_equal "mock_thing >= 'from' AND mock_thing <= 'to'", result
  end
end
