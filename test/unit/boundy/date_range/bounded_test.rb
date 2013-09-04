require File.expand_path('../test_helper', __FILE__)

require 'boundy/date_range/bounded'

class DateRange::BoundedTest < ActiveSupport::TestCase
  setup do
    @before = 5.days.ago
    @after = 2.days.ago
    @range = DateRange::Bounded.new(@before, @after)
  end

  test '#in_range? within' do
    assert(@range.in_range?(4.days.ago .. 3.day.ago) == true)
  end

  test '#in_range? crosses anterior' do
    assert(@range.in_range?(6.days.ago .. 4.day.ago) == true)
  end

  test '#in_range? crosses posterior' do
    assert(@range.in_range?(3.days.ago .. 1.day.ago) == true)
  end

  test '#in_range? too recent' do
    assert(@range.in_range?(2.days.ago .. 1.day.ago) == false)
  end

  test '#in_range? too distant' do
    assert(@range.in_range?(7.days.ago .. 6.day.ago) == false)
  end

  test '#partially_within? strictly before' do
    other_range = DateRange::Bounded.new(7.days.ago, 6.days.ago)

    assert @range.partially_within?(other_range) == false
  end

  test '#partially_within? strictly after' do
    other_range = DateRange::Bounded.new(1.days.ago, 1.days.ago)

    assert @range.partially_within?(other_range) == false

  end

  test '#partially_within? strictly equal' do
    other_range = DateRange::Bounded.new(@before, @after)

    assert @range.partially_within?(other_range) == false

  end

  test '#partially_within? over-reach after' do
    other_range = DateRange::Bounded.new(5.days.ago, 1.days.ago)

    assert @range.partially_within?(other_range) == true
  end

  test '#partially_within? under-reach before' do
    other_range = DateRange::Bounded.new(4.days.ago, 2.days.ago)

    assert @range.partially_within?(other_range) == true

  end

  test '#partially_within? under-reach after' do
    other_range = DateRange::Bounded.new(5.days.ago, 3.days.ago)

    assert @range.partially_within?(other_range) == true
  end

  test '#partially_within? over-reach before over-reach after' do
    other_range = DateRange::Bounded.new(6.days.ago, 1.days.ago)

    assert @range.partially_within?(other_range) == true
  end

  test '#partially_within? over-reach before under-reach after' do
    other_range = DateRange::Bounded.new(6.days.ago, 3.days.ago)

    assert @range.partially_within?(other_range) == true
  end

  test '#partially_within? under-reach before under-reach after' do
    other_range = DateRange::Bounded.new(4.days.ago, 3.days.ago)

    assert @range.partially_within?(other_range) == true
  end

  test '#partially_within? under-reach before over-reach after' do
    other_range = DateRange::Bounded.new(4.days.ago, 1.days.ago)

    assert @range.partially_within?(other_range) == true
  end

  test '#<=> lesser self' do
    other_range = DateRange::Bounded.new(7.days.ago, 6.days.ago)

    result = (@range <=> other_range)
    assert result == -1
  end

  test '#<=> equal self' do
    other_range = DateRange::Bounded.new(@before, @after)

    result = (@range <=> other_range)
    assert result == 0, "#{result}"

  end

  test '#<=> greater self' do
    other_range = DateRange::Bounded.new(1.days.ago, 1.days.ago)

    result = (@range <=> other_range)
    assert result == 1, "#{result}"
  end

  test '#utc' do
    new_range = @range.utc
  end

  test '#in_time_zone' do
    new_range = @range.in_time_zone("PST8PDT")
  end

  test '#to_midnight' do
    new_range = @range.to_midnight
  end
end

class DateRange::Bounded::MidnightAlignedTest < ActiveSupport::TestCase
  setup do
    @before = 5.days.ago
    @after = 2.days.ago
    @bound = DateRange::Bounded::MidnightAligned.new(@before,@after)
  end

  test "aligns to the right anterior midnight" do
    assert_equal @before.beginning_of_day, @bound.from.date
  end

  test "aligns to the right posterior midnight" do
    assert_equal @after.end_of_day, @bound.to.date
  end
end

