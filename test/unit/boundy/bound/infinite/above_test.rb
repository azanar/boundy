require File.expand_path('../../../../test_helper', __FILE__)

require 'boundy/bound'
require 'boundy/bound/infinite/above'

class Boundy::Bound::Infinite::AboveTest < Test::Unit::TestCase
  setup do
    now = Time.now
    @now_bound = Boundy::Bound.new(now)
    @above = Boundy::Bound::Infinite::Above.new
  end

  test "< finite" do
    assert_equal false, @above < @now_bound
  end

  test "> finite" do
    assert_equal true, @above > @now_bound
  end

  test "<= finite" do
    assert_equal false, @above <= @now_bound
  end

  test "=> finite" do
    assert_equal true, @above >= @now_bound
  end

  test "==" do
    assert_equal false, @above == @now_bound
  end

  test "<=> finite" do
    assert_equal 1, @above <=> @now_bound
  end
end
