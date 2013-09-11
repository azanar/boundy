require File.expand_path('../../test_helper', __FILE__)

require 'boundy/domain'

class Boundy::DomainTest < ActiveSupport::TestCase
  setup do
    @now = Time.now
    @before = @now - 5.days

    @tighter_before = @now - 4.days
    @looser_before = @now - 6.days

    @after = @now - 2.days
    @tighter_after = @now - 3.days
    @looser_after = @now - 1.days

    @range = Boundy::Domain.new(@before, @after)
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

  test 'constrain_to datum_bound equal' do
    new = Boundy::Domain.new(@before, @after)

    result = @range.constrain_to(new)

    assert_equal @before, result.from.datum
    assert_equal @after, result.to.datum
  end

  test 'constrain_to datum_bound tighter' do
    new = Boundy::Domain.new(@tighter_before, @tighter_after)

    result = @range.constrain_to(new)

    assert_equal @tighter_before, result.from.datum
    assert_equal @tighter_after, result.to.datum
  end

  test 'constrain_to datum_bound loserr' do
    new = Boundy::Domain.new(@looser_before, @looser_after)

    result = @range.constrain_to(new)

    assert_equal @before, result.from.datum
    assert_equal @after, result.to.datum
  end

  test 'constrain_to range equal' do
    range = (@before .. @after)

    result = @range.constrain_to(range)

    assert_equal @before, result.from.datum
    assert_equal @after, result.to.datum
  end
  test 'constrain_to range tighter' do
    range = (@tighter_before .. @tighter_after)

    result = @range.constrain_to(range)

    assert_equal @tighter_before, result.from.datum
    assert_equal @tighter_after, result.to.datum
  end

  test 'constrain_to range looser' do
    range = (@looser_before .. @looser_after)

    result = @range.constrain_to(range)

    assert_equal @before, result.from.datum
    assert_equal @after, result.to.datum
  end
end

class Boundy::Domain::DayAlignedTest < ActiveSupport::TestCase
  setup do
    @before = 5.days.ago
    @after = 2.days.ago
    @bound = Boundy::Domain::DayAligned.new(@before,@after)
  end

  test "aligns to the right anterior midnight" do
    assert_equal @before.beginning_of_day, @bound.from.datum
  end

  test "aligns to the right posterior midnight" do
    assert_equal @after.end_of_day, @bound.to.datum
  end
end

