require File.expand_path('../../../test_helper', __FILE__)

require 'boundy/bound/comparator'

class Boundy::Bound::ComparatorTest < ActiveSupport::TestCase
  setup do
    @now = Time.now

    @later = @now - 2.days
    @earlier = @now - 5.days
  end

  test '#compare right finite' do
    later = Boundy::Bound.new(@later)
    earlier =Boundy::Bound.new(@earlier)

    result = Boundy::Bound::Comparator.new(earlier, later).compare

    assert_equal :right, result
  end

  test '#compare left finite' do
    later = Boundy::Bound.new(@later)
    earlier =Boundy::Bound.new(@earlier)

    result = Boundy::Bound::Comparator.new(later,earlier).compare

    assert_equal :left, result
  end

  test '#compare right infinite below' do
    later = Boundy::Bound.new(@earlier)
    earlier = Boundy::Bound::Infinite::Below.new

    result = Boundy::Bound::Comparator.new(earlier, later).compare

    assert_equal :right, result
  end

  test '#compare left infinite below' do
    later = Boundy::Bound.new(@earlier)
    earlier = Boundy::Bound::Infinite::Below.new

    result = Boundy::Bound::Comparator.new(later, earlier).compare

    assert_equal :left, result
  end

  test '#compare left infinite above' do
    earlier = Boundy::Bound.new(@earlier)
    later = Boundy::Bound::Infinite::Above.new

    result = Boundy::Bound::Comparator.new(earlier, later).compare

    assert_equal :right, result
  end

  test '#compare right infinite above' do
    earlier = Boundy::Bound.new(@earlier)
    later = Boundy::Bound::Infinite::Above.new

    result = Boundy::Bound::Comparator.new(later, earlier).compare

    assert_equal :left, result
  end
end

