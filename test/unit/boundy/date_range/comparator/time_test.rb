require 'ostruct'

require File.expand_path('../../test_helper', __FILE__)

require 'boundy/date_range/comparator/time'

class DateRange::Comparator::TimeTest < ActiveSupport::TestCase
  @@bound = 5.days.ago

  bounds = [
    {:truthiness => :before?, :time => @@bound - 2.days},
    {:truthiness => :within?, :time => @@bound},
    {:truthiness => :after?, :time => @@bound + 2.days}
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
    test "##{c[:method]}_#{c[:truthiness]}" do
      comp = DateRange::Comparator::Time.new(@@bound, c[:time])

      assert_equal c[:expected], comp.send(c[:method])
    end
  end
end

