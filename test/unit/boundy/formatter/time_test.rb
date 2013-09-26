require File.expand_path('../../../test_helper', __FILE__)

require 'boundy/formatter/time'

class Boundy::Formatter::Time::FactoryTest < ActiveSupport::TestCase
  test "#new" do
    format = "%Y%m%d"
    factory = Boundy::Formatter::Time::Factory.new(format)

    time = Time.now
    result = factory.build(time)

    assert_kind_of Boundy::Formatter::Time, result
  end
end

class Boundy::Formatter::Time::FormatterTest < ActiveSupport::TestCase
  test "#to_s" do 
    time = Time.now
    format = "%Y%m%d"
    formatter = Boundy::Formatter::Time.new(format,time)

    result = formatter.to_s
    assert_equal time.strftime(format), result
  end
end
