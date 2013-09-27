require File.expand_path('../../../../test_helper', __FILE__)

require 'boundy/bound'
require 'boundy/domain/anterior'
require 'boundy/formatters/sql/domain'

class Boundy::Formatters::Sql::DomainTest < ActiveSupport::TestCase
  test "#punch" do
    from = mock
    Boundy::Bound.expects(:===).with(from).returns(true)
    result = Boundy::Formatters::Sql::Domain.formatter(Boundy::Domain::Anterior.new(from))
    
    assert_equal Boundy::Formatters::Sql::Domain::Anterior, result
  end
end

