require File.expand_path('../../test_helper', __FILE__)

require 'boundy/date_range/bounded/posterior'

class DateRange::Bounded::PosteriorTest < ActiveSupport::TestCase
  setup do
    @date = 5.days.ago
    @range = DateRange::Bounded::Posterior.new(@date)
  end
end
