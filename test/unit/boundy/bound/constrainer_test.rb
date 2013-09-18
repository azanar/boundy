require File.expand_path('../../../test_helper', __FILE__)


require 'boundy/bound'
require 'boundy/bound/constrainer'
require 'boundy/bound/infinite'

class Boundy::Bound::ConstrainerTest < ActiveSupport::TestCase
  setup do
    @now = Time.now

    @later = @now - 2.days
    @earlier = @now - 5.days
  end

  test '#max right finite' do
    later =  Boundy::Bound.new(@later)
    earlier = Boundy::Bound.new(@earlier)

    result = Boundy::Bound::Constrainer.new(earlier, later).max

    assert_equal later, result
  end

  test '#max left finite' do
    later = Boundy::Bound.new(@later)
    earlier =Boundy::Bound.new(@earlier)

    result = Boundy::Bound::Constrainer.new(later, earlier).max

    assert_equal later, result
  end

  test '#max right infinite below' do
    later = Boundy::Bound.new(@earlier)
    earlier = Boundy::Bound::Infinite::Below.new

    result = Boundy::Bound::Constrainer.new(earlier,later).max

    assert_equal later, result
  end

  test '#max left infinite below' do
    later = Boundy::Bound.new(@earlier)
    earlier = Boundy::Bound::Infinite::Below.new

    result = Boundy::Bound::Constrainer.new(later, earlier).max

    assert_equal later, result
  end

  test '#max left infinite above' do
    earlier = Boundy::Bound.new(@earlier)
    later = Boundy::Bound::Infinite::Above.new

    result = Boundy::Bound::Constrainer.new(earlier,later).max

    assert_equal later, result
  end

  test '#max right infinite above' do
    earlier = Boundy::Bound.new(@earlier)
    later = Boundy::Bound::Infinite::Above.new

    result = Boundy::Bound::Constrainer.new(later, earlier).max

    assert_equal later, result
  end

  test '#min right finite' do
    later = Boundy::Bound.new(@later)
    earlier =Boundy::Bound.new(@earlier)

    result = Boundy::Bound::Constrainer.new(earlier, later).min

    assert_equal earlier, result
  end

  test '#min left finite' do
    later = Boundy::Bound.new(@later)
    earlier =Boundy::Bound.new(@earlier)

    result = Boundy::Bound::Constrainer.new(later, earlier).min

    assert_equal earlier, result
  end

  test '#min right infinite below' do
    later = Boundy::Bound.new(@earlier)
    earlier = Boundy::Bound::Infinite::Below.new

    result = Boundy::Bound::Constrainer.new(earlier,later).min

    assert_equal earlier, result
  end

  test '#min left infinite below' do
    later = Boundy::Bound.new(@earlier)
    earlier = Boundy::Bound::Infinite::Below.new

    result = Boundy::Bound::Constrainer.new(later, earlier).min

    assert_equal earlier, result
  end

  test '#min left infinite above' do
    earlier = Boundy::Bound.new(@earlier)
    later = Boundy::Bound::Infinite::Above.new

    result = Boundy::Bound::Constrainer.new(earlier,later).min

    assert_equal earlier, result
  end

  test '#min right infinite above' do
    earlier = Boundy::Bound.new(@earlier)
    later = Boundy::Bound::Infinite::Above.new

    result = Boundy::Bound::Constrainer.new(later, earlier).min

    assert_equal earlier, result
  end
end
