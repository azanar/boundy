require File.expand_path('../test_helper', __FILE__)

require 'boundy/bound'
require 'boundy/domain'

class Boundy::Domain::Test < Test::Unit::TestCase
  test "domain" do
    now = Time.new(2013,9,1)

    from = Boundy::Bound.new(now - 5.day)
    to = Boundy::Bound.new(now - 1.day)

    domain = Boundy::Domain.new(from,to)

    other_from = Boundy::Bound.new(now - 2.day)
    other_domain = Boundy::Domain::Posterior.new(other_from)
  end
end
