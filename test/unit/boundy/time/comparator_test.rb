require File.expand_path('../../../test_helper', __FILE__)

require 'boundy/time/comparator'

class Boundy::Time::ComparatorTest < Test::Unit::TestCase
  setup do
    mock_time = mock

    mock_bound = mock

    mock_comparable_bound = mock

    Boundy::Bound.expects(:new).with(mock_time).returns(mock_comparable_bound)

    @mock_comparator = mock

    Boundy::Bound::Comparator.expects(:new).with(mock_bound, mock_comparable_bound).returns(@mock_comparator)

    @comp = Boundy::Time::Comparator.new(mock_bound, mock_time)
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

