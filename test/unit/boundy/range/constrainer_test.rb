require File.expand_path('../../../test_helper', __FILE__)

require 'boundy/range/constrainer'

class Boundy::Range::ConstrainerTest < Test::Unit::TestCase
  test "foo" do
    range = (5.days.ago .. 1.day.ago)
    mock_bound = mock
    Boundy::Range::Constrainer.new(mock_bound, range)
  end
end
