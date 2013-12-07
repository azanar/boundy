require File.expand_path('../../../test_helper', __FILE__)

require 'boundy/bound/comparator'

class Boundy::Bound::ComparatorTest < Test::Unit::TestCase
  time = 5.days.ago
  bound = Boundy::Bound.new(time)

  bounds = [
    {:truthiness => :before?, :time => time - 2.days},
    {:truthiness => :within?, :time => time},
    {:truthiness => :after?, :time => time + 2.days}
  ]

  methods = [:before?, :after?, :within?]

  cases = bounds.product(methods).map do |p| 
    c = p[0]
    m = p[1]
    t = c[:truthiness]

    expected = (c[:truthiness] == m)
    {:time => c[:time], 
     :method => m, 
     :truthiness => t,
     :expected => expected
    }
  end

  cases.each do |c|
    test "#{c[:method]}_#{c[:truthiness]}" do
      comp = Boundy::Bound::Comparator.new(bound, Boundy::Bound.new(c[:time]))

      assert_equal c[:expected], comp.method(c[:method]).call
    end
  end
end
