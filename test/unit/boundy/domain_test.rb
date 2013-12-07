require File.expand_path('../../test_helper', __FILE__)

require 'boundy/domain'
require 'boundy/domain/finite'
require 'boundy/range/comparator'

class Boundy::DomainTest < Test::Unit::TestCase
  setup do
    @now = Time.now
    @before = @now - 5.days

    @tighter_before = @now - 4.days
    @looser_before = @now - 6.days

    @after = @now - 2.days
    @tighter_after = @now - 3.days
    @looser_after = @now - 1.days

    @domain = Boundy::Domain.new(@before, @after)
  end

  test 'constrain_to domain equal' do
    new = Boundy::Domain.new(@before, @after)

    result = @domain.constrain_to(new)

    assert_equal @before, result.from.datum
    assert_equal @after, result.to.datum
  end

  test 'constrain_to domain tighter' do
    new = Boundy::Domain.new(@tighter_before, @tighter_after)

    result = @domain.constrain_to(new)

    assert_equal @tighter_before, result.from.datum
    assert_equal @tighter_after, result.to.datum
  end

  test 'constrain_to domain loserr' do
    new = Boundy::Domain.new(@looser_before, @looser_after)

    result = @domain.constrain_to(new)

    assert_equal @before, result.from.datum
    assert_equal @after, result.to.datum
  end
end


