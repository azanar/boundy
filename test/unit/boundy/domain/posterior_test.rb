require File.expand_path('../../../test_helper', __FILE__)

require 'boundy/domain'
require 'boundy/domain/posterior'

class Boundy::Domain::PosteriorTest < Test::Unit::TestCase
  setup do
    @now = Time.now
    @before = @now - 5.days

    @tighter_before = @now - 4.days
    @looser_before = @now - 6.days

    @after = @now - 2.days
    @tighter_after = @now - 3.days
    @looser_after = @now - 1.days

    @datum = @after

    @range = Boundy::Domain::Posterior.new(@datum)
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

  test 'constrain_to datum_bound looser' do
    new = Boundy::Domain.new(@looser_before, @looser_after)

    result = @range.constrain_to(new)

    assert_equal @looser_before, result.from.datum
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

    assert_equal @looser_before, result.from.datum
    assert_equal @after, result.to.datum
  end
end
