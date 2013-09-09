require File.expand_path('../../../../../test_helper', __FILE__)

require 'boundy/date_range/bounded/constrainer/bounded'

class Boundy::DateRange::Bounded::Constrainer::BoundedTest < ActiveSupport::TestCase
  test "foo" do
    mock_range = mock
    mock_bound = mock
    Boundy::DateRange::Bounded::Constrainer::Bounded.new(mock_range,mock_bound)
  end
end
