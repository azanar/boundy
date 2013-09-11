require File.expand_path('../../test_helper', __FILE__)

require 'boundy/bound'

class Boundy::BoundTest < ActiveSupport::TestCase
  setup do
    @bound = Boundy::Bound.new(5.days.ago)
  end
end

