require File.expand_path('../test_helper', __FILE__)

require 'boundy/bound'
require 'boundy/domain'

require 'boundy/formatters/sql/bound'
require 'boundy/formatters/time'
require 'boundy/formatter/sql'

class Boundy::Test < Test::Unit::TestCase
  test "foo" do
    now = Time.new(2013,9,1)

    from = Boundy::Bound.new(now - 5.day)
    to = Boundy::Bound.new(now - 1.day)

    domain = Boundy::Domain.new(from,to)
    
    formatter = Boundy::Formatter::Sql.new(domain, "foo")

    assert_equal "foo >= '2013-08-27 00:00:00' AND foo <= '2013-08-31 00:00:00'", formatter.to_s
  end

  test 'bar' do

    now = Time.new(2013,9,1)

    from = Boundy::Bound.new(now - 5.day)
    to = Boundy::Bound.new(now - 1.day)

    domain = Boundy::Domain.new(from,to)

    other_from = Boundy::Bound.new(now - 2.day)
    other_domain = Boundy::Domain::Posterior.new(other_from)

  end
end
