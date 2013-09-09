require 'ostruct'

require File.expand_path('../../../../test_helper', __FILE__)

require 'boundy/date_range/bounded/bound'

class Boundy::DateRange::Bounded::BoundTest < ActiveSupport::TestCase
  setup do
    @bound = Boundy::DateRange::Bounded::Bound.new(5.days.ago)
  end
  
  test '#utc' do
    new_bound = @bound.utc

    assert_equal "UTC", new_bound.date.zone
  end

  test '#in_time_zone' do
    new_zone = @bound.in_time_zone('PST8PDT')

    assert_equal "PDT", new_zone.date.zone
  end
end

