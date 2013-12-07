require File.expand_path('../../../test_helper', __FILE__)

require 'boundy/formatters/time'

class Boundy::Formatters::Time::FactoryTest < Test::Unit::TestCase
  test "#new" do
    format = "%Y%m%d"
    factory = Boundy::Formatters::Time::Factory.new(format)

    Boundy::Formatters::Time.factory = factory
    time = Time.now
    result = factory.build(time, "name")

    assert_kind_of Boundy::Formatters::Time, result
  end
end

class Boundy::Formatters::Time::FormatterTest < Test::Unit::TestCase
  test "#to_s" do 
    time = Time.now
    format = "%Y%m%d"
    formatter = Boundy::Formatters::Time.new(format,time)

    result = formatter.to_s
    assert_equal time.strftime(format), result
  end
end
