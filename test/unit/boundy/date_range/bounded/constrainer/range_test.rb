require File.expand_path('../../../../../test_helper', __FILE__)

require 'boundy/date_range/bounded/constrainer/range'

class Boundy::DateRange::Bounded::Constrainer::RangeTest < ActiveSupport::TestCase
  test "foo" do
    range = (5.days.ago .. 1.day.ago)
    mock_bound = mock
    Boundy::DateRange::Bounded::Constrainer::Range.new(mock_bound, range)
  end
end
