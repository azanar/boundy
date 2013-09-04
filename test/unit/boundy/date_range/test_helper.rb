$:.push('lib')

require 'active_support/time'
require 'active_support/test_case'
require 'test/unit'

if ENV["ENABLE_SIMPLE_COV"]
  require 'simplecov'
  require File.expand_path('../simplecov_helper', __FILE__)
  SimpleCov.start 'pocketchange'
end
