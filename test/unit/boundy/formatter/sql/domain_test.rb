require File.expand_path('../../../../test_helper', __FILE__)

require 'boundy/bound'
require 'boundy/domain/anterior'
require 'boundy/formatter/sql/domain'

class Boundy::Formatter::Sql::DomainTest < ActiveSupport::TestCase
  test "#punch" do
    puts Boundy::Formatter::Sql::Domain.puncher.inspect
    from = mock
    Boundy::Bound.expects(:===).with(from).returns(true)
    to = mock
    #from.expects(:<=).with(to).returns(true)
    puts Boundy::Formatter::Sql::Domain.formatter(Boundy::Domain::Anterior.new(from))
  end
end

