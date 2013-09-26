require File.expand_path('../../../test_helper', __FILE__)

require 'boundy/time/formatter'

class Boundy::Time::FactoryTest < ActiveSupport::TestCase
  test "#new" do
    format = "%Y%m%d"
    factory = Boundy::Time::Formatter::Factory.new(format)

    time = Time.now
    result = factory.build(time)

    assert_kind_of Boundy::Time::Formatter, result
  end
end

class Boundy::Time::FormatterTest < ActiveSupport::TestCase
  test "#to_s" do 
    time = Time.now
    format = "%Y%m%d"
    formatter = Boundy::Time::Formatter.new(format,time)

    result = formatter.to_s
    assert_equal time.strftime(format), result
  end
end
