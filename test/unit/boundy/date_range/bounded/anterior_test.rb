require File.expand_path('../../test_helper', __FILE__)

require 'boundy/date_range/bounded/anterior'

class DateRange::Bounded::AnteriorTest < ActiveSupport::TestCase
  setup do
    @date = 5.days.ago
    @range = DateRange::Bounded::Anterior.new(@date)
  end
end

