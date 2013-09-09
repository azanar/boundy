require File.expand_path('../../../../test_helper', __FILE__)

require 'boundy/date_range/comparator/bound'

class Boundy::DateRange::Comparator::BoundTest < ActiveSupport::TestCase
  setup do
    @now = Time.now

    @later = @now - 2.days
    @earlier = @now - 5.days
  end

  test '#compare right finite' do
    later = Boundy::DateRange::Bounded::Bound.new(@later)
    earlier =Boundy::DateRange::Bounded::Bound.new(@earlier)

    result = Boundy::DateRange::Comparator::Bound.new(earlier, later).compare

    assert_equal :right, result
  end

  test '#compare left finite' do
    later = Boundy::DateRange::Bounded::Bound.new(@later)
    earlier =Boundy::DateRange::Bounded::Bound.new(@earlier)

    result = Boundy::DateRange::Comparator::Bound.new(later,earlier).compare

    assert_equal :left, result
  end

  test '#compare right infinite below' do
    later = Boundy::DateRange::Bounded::Bound.new(@earlier)
    earlier = Boundy::DateRange::Bounded::Bound::Infinite::Below.new

    result = Boundy::DateRange::Comparator::Bound.new(earlier, later).compare

    assert_equal :right, result
  end

  test '#compare left infinite below' do
    later = Boundy::DateRange::Bounded::Bound.new(@earlier)
    earlier = Boundy::DateRange::Bounded::Bound::Infinite::Below.new

    result = Boundy::DateRange::Comparator::Bound.new(later, earlier).compare

    assert_equal :left, result
  end

  test '#compare left infinite above' do
    earlier = Boundy::DateRange::Bounded::Bound.new(@earlier)
    later = Boundy::DateRange::Bounded::Bound::Infinite::Above.new

    result = Boundy::DateRange::Comparator::Bound.new(earlier, later).compare

    assert_equal :right, result
  end

  test '#compare right infinite above' do
    earlier = Boundy::DateRange::Bounded::Bound.new(@earlier)
    later = Boundy::DateRange::Bounded::Bound::Infinite::Above.new

    result = Boundy::DateRange::Comparator::Bound.new(later, earlier).compare

    assert_equal :left, result
  end
end

