require File.expand_path('../../../test_helper', __FILE__)

require 'boundy/bound'
require 'boundy/range/comparator'

class Boundy::Range::ComparatorTest < Test::Unit::TestCase
  setup do
    mock_begin = mock
    mock_end = mock

    mock_range = mock
    mock_range.expects(:begin).returns(mock_begin)
    mock_range.expects(:end).returns(mock_end)

    mock_domain = mock

    Boundy::Domain.expects(:new).with(mock_begin, mock_end).returns(mock_domain)

    @mock_comparator = mock
    mock_bound = mock

    Boundy::Domain::Comparator.expects(:new).with(mock_bound, mock_domain).returns(@mock_comparator)

    @comp = Boundy::Range::Comparator.new(mock_bound, mock_range)
  end

  test "#before?" do
    @mock_comparator.expects(:before?).returns(true)

    assert_equal @comp.before?, true
  end

  test "#within?" do
    @mock_comparator.expects(:within?).returns(true)

    assert_equal @comp.within?, true
  end

  test "#after?" do
    @mock_comparator.expects(:after?).returns(true)

    assert_equal @comp.after?, true
  end
end
