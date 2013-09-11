require File.expand_path('../../../test_helper', __FILE__)

require 'boundy/time/bound'

class Boundy::Time::BoundTest < ActiveSupport::TestCase
  setup do
    @bound = Boundy::Time::Bound.new(5.days.ago)
  end
  test '#utc' do
    new_bound = @bound.utc

    assert_equal "UTC", new_bound.datum.zone
  end

  test '#in_time_zone' do
    new_zone = @bound.in_time_zone('PST8PDT')

    assert_equal "PDT", new_zone.datum.zone
  end
end
