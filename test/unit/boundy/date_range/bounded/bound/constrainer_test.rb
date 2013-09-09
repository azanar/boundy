require File.expand_path('../../../../../test_helper', __FILE__)


require 'boundy/date_range/bounded/bound'
require 'boundy/date_range/bounded/bound/constrainer'
require 'boundy/date_range/bounded/bound/infinite'

class Boundy::DateRange::Bounded::ConstrainerTest < ActiveSupport::TestCase
  setup do
    @now = Time.now

    @later = @now - 2.days
    @earlier = @now - 5.days
  end

  test '#max right finite' do
    later = Boundy::DateRange::Bounded::Bound.new(@later)
    earlier =Boundy::DateRange::Bounded::Bound.new(@earlier)

    result = Boundy::DateRange::Bounded::Bound::Constrainer.new(earlier, later).max

    assert_equal later, result
  end

  test '#max left finite' do
    later = Boundy::DateRange::Bounded::Bound.new(@later)
    earlier =Boundy::DateRange::Bounded::Bound.new(@earlier)

    result = Boundy::DateRange::Bounded::Bound::Constrainer.new(later, earlier).max

    assert_equal later, result
  end

  test '#max right infinite below' do
    later = Boundy::DateRange::Bounded::Bound.new(@earlier)
    earlier = Boundy::DateRange::Bounded::Bound::Infinite::Below.new

    result = Boundy::DateRange::Bounded::Bound::Constrainer.new(earlier,later).max

    assert_equal later, result
  end

  test '#max left infinite below' do
    later = Boundy::DateRange::Bounded::Bound.new(@earlier)
    earlier = Boundy::DateRange::Bounded::Bound::Infinite::Below.new

    result = Boundy::DateRange::Bounded::Bound::Constrainer.new(later, earlier).max

    assert_equal later, result
  end

  test '#max left infinite above' do
    earlier = Boundy::DateRange::Bounded::Bound.new(@earlier)
    later = Boundy::DateRange::Bounded::Bound::Infinite::Above.new

    result = Boundy::DateRange::Bounded::Bound::Constrainer.new(earlier,later).max

    assert_equal later, result
  end

  test '#max right infinite above' do
    earlier = Boundy::DateRange::Bounded::Bound.new(@earlier)
    later = Boundy::DateRange::Bounded::Bound::Infinite::Above.new

    result = Boundy::DateRange::Bounded::Bound::Constrainer.new(later, earlier).max

    assert_equal later, result
  end

  test '#min right finite' do
    later = Boundy::DateRange::Bounded::Bound.new(@later)
    earlier =Boundy::DateRange::Bounded::Bound.new(@earlier)

    result = Boundy::DateRange::Bounded::Bound::Constrainer.new(earlier, later).min

    assert_equal earlier, result
  end

  test '#min left finite' do
    later = Boundy::DateRange::Bounded::Bound.new(@later)
    earlier =Boundy::DateRange::Bounded::Bound.new(@earlier)

    result = Boundy::DateRange::Bounded::Bound::Constrainer.new(later, earlier).min

    assert_equal earlier, result
  end

  test '#min right infinite below' do
    later = Boundy::DateRange::Bounded::Bound.new(@earlier)
    earlier = Boundy::DateRange::Bounded::Bound::Infinite::Below.new

    result = Boundy::DateRange::Bounded::Bound::Constrainer.new(earlier,later).min

    assert_equal earlier, result
  end

  test '#min left infinite below' do
    later = Boundy::DateRange::Bounded::Bound.new(@earlier)
    earlier = Boundy::DateRange::Bounded::Bound::Infinite::Below.new

    result = Boundy::DateRange::Bounded::Bound::Constrainer.new(later, earlier).min

    assert_equal earlier, result
  end

  test '#min left infinite above' do
    earlier = Boundy::DateRange::Bounded::Bound.new(@earlier)
    later = Boundy::DateRange::Bounded::Bound::Infinite::Above.new

    result = Boundy::DateRange::Bounded::Bound::Constrainer.new(earlier,later).min

    assert_equal earlier, result
  end

  test '#min right infinite above' do
    earlier = Boundy::DateRange::Bounded::Bound.new(@earlier)
    later = Boundy::DateRange::Bounded::Bound::Infinite::Above.new

    result = Boundy::DateRange::Bounded::Bound::Constrainer.new(later, earlier).min

    assert_equal earlier, result
  end
end
