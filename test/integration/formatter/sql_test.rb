require File.expand_path('../../test_helper', __FILE__)

require 'boundy/bound'
require 'boundy/domain'

require 'boundy/formatters/bound'
require 'boundy/formatters/fixnum'
require 'boundy/formatters/time'
require 'boundy/formatter/sql'

class Boundy::Formatter::Sql::Test < Test::Unit::TestCase
  test "foo" do
    lower = Boundy::Bound.new(1)
    upper = Boundy::Bound.new(10)
    domain = Boundy::Domain.new(lower, upper)

    formatter = Boundy::Formatter::Sql.new(domain, "domain")

    assert_equal formatter.to_s, "domain >= '1' AND domain <= '10'"
  end
end
