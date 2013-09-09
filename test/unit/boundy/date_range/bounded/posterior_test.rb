require File.expand_path('../../../../test_helper', __FILE__)

require 'boundy/date_range/bounded'
require 'boundy/date_range/bounded/posterior'

class Boundy::DateRange::Bounded::PosteriorTest < ActiveSupport::TestCase
  setup do
    @now = Time.now
    @before = @now - 5.days

    @tighter_before = @now - 4.days
    @looser_before = @now - 6.days

    @after = @now - 2.days
    @tighter_after = @now - 3.days
    @looser_after = @now - 1.days

    @date = @after

    @range = Boundy::DateRange::Bounded::Posterior.new(@date)
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

  test 'constrain_to date_bound looser' do
    new = Boundy::DateRange::Bounded.new(@looser_before, @looser_after)

    result = @range.constrain_to(new)

    assert_equal @looser_before, result.from.date
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

    assert_equal @looser_before, result.from.date
    assert_equal @after, result.to.date
  end
end
