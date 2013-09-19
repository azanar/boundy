require File.expand_path('../../../test_helper', __FILE__)

require 'boundy/domain'
require 'boundy/domain/anterior'

class Boundy::Domain::AnteriorTest < ActiveSupport::TestCase
  setup do
    @now = Time.now

    @before = @now - 5.days

    @tighter_before = @now - 4.days
    @looser_before = @now - 6.days

    @after = @now - 2.days
    @tighter_after = @now - 3.days
    @looser_after = @now - 1.days

    @datum = @before

    @range = Boundy::Domain::Anterior.new(@datum)
  end

  # constrain_to
  test 'constrain_to domain equal' do
    new = Boundy::Domain.new(@before, @after)

    result = @range.constrain_to(new)

    puts "RESULT #{result.inspect}"
    assert_equal @before, result.from.datum
    assert_equal @after, result.to.datum
  end

  test 'constrain_to domain tighter' do
    new = Boundy::Domain.new(@tighter_before, @tighter_after)

    result = @range.constrain_to(new)

    assert_equal @tighter_before, result.from.datum
    assert_equal @tighter_after, result.to.datum
  end

  test 'constrain_to domain loserr' do
    new = Boundy::Domain.new(@looser_before, @looser_after)

    result = @range.constrain_to(new)

    assert_equal @before, result.from.datum
    assert_equal @looser_after, result.to.datum
  end

  test 'constrain_to anterior domain equal' do
    new = Boundy::Domain::Anterior.new(@before)

    result = @range.constrain_to(new)

    assert_equal @before, result.from.datum
  end

  test 'constrain_to anterior domain tighter' do
    new = Boundy::Domain::Anterior.new(@tighter_before)

    result = @range.constrain_to(new)

    assert_equal @tighter_before, result.from.datum
  end

  test 'constrain_to anterior domain loserr' do
    new = Boundy::Domain::Anterior.new(@looser_before)

    result = @range.constrain_to(new)

    assert_equal @before, result.from.datum
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

