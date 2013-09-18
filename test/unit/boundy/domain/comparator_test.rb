require File.expand_path('../../../test_helper', __FILE__)

require 'boundy/bound'
require 'boundy/domain'
require 'boundy/domain/comparator'

class Boundy::Domain::ComparatorTest < ActiveSupport::TestCase
  time = 5.days.ago
  test_bound = Boundy::Bound.new(time)

  times = [
    {
      name: "behind",
      range: (time - 2.days .. time - 1.day),
      truthiness: [
        {method: :before?}
      ]
    },
    {
      name: "touching from behind",
      range: (time - 1.days .. time),
      truthiness: [
        {method: :within?}
      ]
    },
    {
      name: "within",
      range: (time - 1.days .. time + 1.day),
      truthiness: [
        {method: :within?}
      ]
    },
    {
      name: "touching from ahead",
      range: (time .. time + 1.day),
      truthiness: [
        {method: :within?}
      ]
    },
    {
      name: "ahead",
      range: (time + 1.days .. time + 2.day),
      truthiness: [
        {method: :after?}
      ]
    }
  ]

  methods = [:before?, :after?, :within?]

  cases = times.product(methods).map do |p| 
    t = p[0]
    method = p[1]
    truthiness = t[:truthiness]

    expected = (truthiness.include?({method: method}))

    t.merge({ :method => method, 
              :expected => expected,
              :failure => "#{method} failed"
    })
  end


  cases.each do |c|
    test "##{c[:method]}_#{c[:name]}" do
      range = c[:range]
      domain = Boundy::Domain.new(range.begin, range.end)
      comp = Boundy::Domain::Comparator.new(test_bound, domain)

      assert_equal c[:expected], comp.method(c[:method]).call
    end
  end
end

