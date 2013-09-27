require File.expand_path('../../../test_helper', __FILE__)

require 'boundy/formatter/domain'

class Boundy::Formatter::DomainTest < ActiveSupport::TestCase
  test "#format" do
    mock_range = mock
    mock_bound = mock
    Boundy::Domain::Constrainer.new(mock_range,mock_bound)
  end
end
