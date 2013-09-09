require File.expand_path('../../../test_helper', __FILE__)

require 'boundy/date_range/bounded'

class Boundy::DateRange::BoundedTest < ActiveSupport::TestCase
  setup do
    @now = Time.now
    @before = @now - 5.days

    @tighter_before = @now - 4.days
    @looser_before = @now - 6.days

    @after = @now - 2.days
    @tighter_after = @now - 3.days
    @looser_after = @now - 1.days

    @range = Boundy::DateRange::Bounded.new(@before, @after)
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

  test '#utc' do
    @range.utc
  end

  test '#in_time_zone' do
    @range.in_time_zone("PST8PDT")
  end

  test '#to_midnight' do
    @range.to_midnight
  end

  test 'constrain_to date_bound equal' do
    new = Boundy::DateRange::Bounded.new(@before, @after)

    result = @range.constrain_to(new)

    assert_equal @before, result.from.date
    assert_equal @after, result.to.date
  end

  test 'constrain_to date_bound tighter' do
    new = Boundy::DateRange::Bounded.new(@tighter_before, @tighter_after)

    result = @range.constrain_to(new)

    assert_equal @tighter_before, result.from.date
    assert_equal @tighter_after, result.to.date
  end

  test 'constrain_to date_bound loserr' do
    new = Boundy::DateRange::Bounded.new(@looser_before, @looser_after)

    result = @range.constrain_to(new)

    assert_equal @before, result.from.date
    assert_equal @after, result.to.date
  end

  test 'constrain_to range equal' do
    range = (@before .. @after)

    result = @range.constrain_to(range)

    assert_equal @before, result.from.date
    assert_equal @after, result.to.date
  end
  test 'constrain_to range tighter' do
    range = (@tighter_before .. @tighter_after)

    result = @range.constrain_to(range)

    assert_equal @tighter_before, result.from.date
    assert_equal @tighter_after, result.to.date
  end

  test 'constrain_to range looser' do
    range = (@looser_before .. @looser_after)

    result = @range.constrain_to(range)

    assert_equal @before, result.from.date
    assert_equal @after, result.to.date
  end
end

class Boundy::DateRange::Bounded::DayAlignedTest < ActiveSupport::TestCase
  setup do
    @before = 5.days.ago
    @after = 2.days.ago
    @bound = Boundy::DateRange::Bounded::DayAligned.new(@before,@after)
  end

  test "aligns to the right anterior midnight" do
    assert_equal @before.beginning_of_day, @bound.from.date
  end

  test "aligns to the right posterior midnight" do
    assert_equal @after.end_of_day, @bound.to.date
  end
end

