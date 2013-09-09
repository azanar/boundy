$:.push('lib')

if ENV["ENABLE_SIMPLE_COV"]
  require 'simplecov'
#  require File.expand_path('../simplecov_helper', __FILE__)
  SimpleCov.start do
    add_filter "test"
    add_group 'API',          "lib"
  end
end

require 'active_support/time'
require 'active_support/test_case'
require 'test/unit'

