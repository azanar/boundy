require File.expand_path('../../../../test_helper', __FILE__)

require 'boundy/domain/formatter/sql'

class Boundy::Domain::Formatter::SqlTest < ActiveSupport::TestCase
  setup do

    mock_domain = mock

    @mock_from = mock
    @mock_to = mock

    mock_domain.expects(:from).returns(@mock_from)
    mock_domain.expects(:to).returns(@mock_to)

    @mock_from_formatter = mock
    @mock_to_formatter = mock

    Boundy::Bound::Formatter.expects(:new).with(@mock_from).returns(@mock_from_formatter)
    Boundy::Bound::Formatter.expects(:new).with(@mock_to).returns(@mock_to_formatter)

    @formatter = Boundy::Domain::Formatter::Sql.new(mock_domain)
  end

  test "#format anterior" do
    @mock_from.expects(:infinite?).returns(false)
    @mock_to.expects(:infinite?).returns(true)
    
    @mock_from_formatter.expects(:format).returns("from")
    @mock_to_formatter.expects(:format).never

    result = @formatter.to_s
    
    assert_equal ">= 'from'", result
  end

  test "#format posterior" do
    @mock_from.expects(:infinite?).returns(true)
    @mock_to.expects(:infinite?).never

    @mock_from_formatter.expects(:format).never
    @mock_to_formatter.expects(:format).returns("to")

    result = @formatter.to_s

    assert_equal "<= 'to'", result
  end

  test "#format finite" do
    @mock_from.expects(:infinite?).returns(false)
    @mock_to.expects(:infinite?).returns(false)

    @mock_from_formatter.expects(:format).returns("from")
    @mock_to_formatter.expects(:format).returns("to")

    result = @formatter.to_s

    assert_equal "BETWEEN 'from' AND 'to'", result
  end
end

