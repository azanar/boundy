require File.expand_path('../../test_helper', __FILE__)

require 'boundy/bound'
require 'boundy/domain'
require 'boundy/domain/anterior'
require 'boundy/domain/posterior'

class Boundy::BoundTest < ActiveSupport::TestCase
  time = 5.days.ago
  test_bound = Boundy::Bound.new(time)

  times = [
    {
      name: "behind",
      time: time - 2.days,
      truthiness: [
        {method: :within?, domain: :anterior},
        {method: :before?, domain: :posterior}
      ]
    },
    {
      name: "equal",
      time: time,
      truthiness: [
        {method: :within?, domain: :anterior},
        {method: :within?, domain: :posterior},
        {method: :within?, domain: :enclosed}
      ]
    },
    {
      name: "ahead",
      time: time + 2.days,
      truthiness: [
        {method: :within?, domain: :posterior},
        {method: :after?, domain: :anterior}
      ]
    }
  ]

  domain_classes = {
    :anterior => Boundy::Domain::Anterior,
    :posterior => Boundy::Domain::Posterior,
    :enclosed => Boundy::Domain
  }

  domains = [:anterior, :posterior]
  methods = [:before?, :within?, :after?]

  cases = times.product(methods, domains).map do |p| 
    t = p[0]
    method = p[1]
    domain = p[2]

    truthiness = t[:truthiness]
    klass = domain_classes[domain]

    expected = (truthiness.include?({method: method, domain: domain}))

    t.merge({ :method => method, 
     :domain => domain,
     :class => klass,
     :expected => expected,
     :failure => "#{domain.to_s}##{method} against #{t[:time]}"
    })
  end


  cases.each do |c|
    test "##{c[:domain]}##{c[:method]}_#{c[:name]}" do
      bound = Boundy::Bound.new(c[:time])
      domain = c[:class].new(bound)
      result = test_bound.method(c[:method]).call(domain)
      assert_equal c[:expected], result, c[:failure]
    end
  end
end
