require File.expand_path('../../../test_helper', __FILE__)

require 'boundy/bounded'
require 'boundy/bounded/anterior'

class Boundy::Bounded::AnteriorTest < ActiveSupport::TestCase
  setup do
    @now = Time.now

    @before = @now - 5.days

    @tighter_before = @now - 4.days
    @looser_before = @now - 6.days

    @after = @now - 2.days
    @tighter_after = @now - 3.days
    @looser_after = @now - 1.days

    @datum = @before

    @range = Boundy::Bounded::Anterior.new(@datum)
  end

  test 'constrain_to datum_bound equal' do
    new = Boundy::Bounded.new(@before, @after)

    result = @range.constrain_to(new)

    assert_equal @before, result.from.datum
    assert_equal @after, result.to.datum
  end

  test 'constrain_to datum_bound tighter' do
    new = Boundy::Bounded.new(@tighter_before, @tighter_after)

    result = @range.constrain_to(new)

    assert_equal @tighter_before, result.from.datum
    assert_equal @tighter_after, result.to.datum
  end

  test 'constrain_to datum_bound loserr' do
    new = Boundy::Bounded.new(@looser_before, @looser_after)

    result = @range.constrain_to(new)

    assert_equal @before, result.from.datum
    assert_equal @looser_after, result.to.datum
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
    assert_equal @looser_after, result.to.datum
  end
end

