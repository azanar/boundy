require File.expand_path('../../../test_helper', __FILE__)

require 'boundy/domain/formatter'

class Boundy::Domain::FormatterTest < ActiveSupport::TestCase
  test "#format" do
    mock_range = mock
    mock_bound = mock
    Boundy::Domain::Constrainer.new(mock_range,mock_bound)
  end
end

