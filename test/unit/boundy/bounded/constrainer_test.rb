require File.expand_path('../../../test_helper', __FILE__)

require 'boundy/bounded/constrainer'

class Boundy::Bounded::ConstrainerTest < ActiveSupport::TestCase
  test "foo" do
    mock_range = mock
    mock_bound = mock
    Boundy::Bounded::Constrainer.new(mock_range,mock_bound)
  end
end
